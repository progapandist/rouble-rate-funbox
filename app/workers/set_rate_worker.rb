require 'pusher'

class SetRateWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly }

  def perform
    cb_rate = CBRateFinder.dollar
    last_rate = ExchangeRate.last.rate
    ExchangeRate.create(rate: cb_rate, date: Time.now) unless last_rate == cb_rate
    puts "Got a rate from CBR: #{rate}, DB ID: #{ExchangeRate.last.id}"
    Pusher.trigger('rate-updates', 'rate-updated', {
      latest_rate: rate
    })
  end
end
