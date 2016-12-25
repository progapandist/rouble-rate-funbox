require 'pusher'

class SetRateWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly }

  def perform
    rate = CBRateFinder.dollar
    ExchangeRate.create(rate: rate, date: Time.now)
    puts "Got a rate from CBR: #{rate}, DB ID: #{ExchangeRate.last.id}"
    Pusher.trigger('rate-updates', 'rate-updated', {
      latest_rate: rate
    })
  end
end
