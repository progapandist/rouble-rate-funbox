class ExchangeRatesController < ApplicationController
  def current_rate
    @current = ExchangeRate.order(:date).last
  end
end
