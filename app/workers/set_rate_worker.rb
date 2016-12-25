class SetRateWorker
  include Sidekiq::Worker

  def perform
    rate = CBRateFinder.dollar
    ExchangeRate.create(rate: rate, date: Time.now)
  end
end
