class ExchangeRatesController < ApplicationController
  def current_rate
    # cb_rate = CBRateFinder.dollar
    # last_rate = ExchangeRate.last.rate.to_f
    # ExchangeRate.create(rate: cb_rate, date: Time.now) unless last_rate == cb_rate
    @current_rate = ExchangeRate.order(:date).last.rate
    SetRateWorker.perform_async # start recurrence
  end
end
