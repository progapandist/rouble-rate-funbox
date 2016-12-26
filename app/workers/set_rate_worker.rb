require 'pusher'

class SetRateWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly }

  def perform
    cb_rate = CBRateFinder.dollar
    last_rate = ExchangeRate.last
    if last_rate.date < Time.current
      ExchangeRate.create(rate: cb_rate, date: Time.current)
      puts "Got a rate from CBR: #{cb_rate}, DB ID: #{ExchangeRate.last.id}"
      Pusher.trigger('rate-updates', 'rate-updated', {
        latest_rate: cb_rate
      })
    end
  end
end
