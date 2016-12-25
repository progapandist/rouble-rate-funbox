class ExchangeRatesController < ApplicationController
  def current_rate
    cb_rate = CBRateFinder.dollar
    last_rate = ExchangeRate.last.rate
    ExchangeRate.create(rate: cb_rate, date: Time.now) unless last_rate == cb_rate
    @current = ExchangeRate.order(:date).last
    SetRateWorker.perform_async
  end
end
