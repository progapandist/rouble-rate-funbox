class SetRateWorker
  include Sidekiq::Worker

  def perform
    rate = CBRateFinder.dollar
    ExchangeRate.create(rate: rate, date: Time.now)
    puts "Got a rate from CBR: #{rate}, DB ID: #{ExchangeRate.last.id}"
  end
end
