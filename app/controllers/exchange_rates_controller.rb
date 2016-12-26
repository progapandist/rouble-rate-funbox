class ExchangeRatesController < ApplicationController
  around_action :set_time_zone

  def index
    last_rate = ExchangeRate.last
    if last_rate.date < Time.now
      cb_rate = CBRateFinder.dollar
      ExchangeRate.create(rate: cb_rate, date: Time.now.utc)
    end
    @current_rate = ExchangeRate.last
    SetRateWorker.perform_async # start recurrence
  end

  def edit
    @exchange_rate = ExchangeRate.order(:date).last
  end

  def update
    @exchange_rate = ExchangeRate.last
    @exchange_rate.update(exchange_rate_params)
    seconds_from_now = ExchangeRate.last.date.to_i - Time.now.to_i
    SetRateWorker.perform_in(seconds_from_now.seconds)
    redirect_to action: 'index'
    Pusher.trigger('rate-updates', 'rate-updated', {
      latest_rate: @exchange_rate.rate
    })
  end

  private

  def exchange_rate_params
    params.require(:exchange_rate).permit(:rate, :date)
  end

  # workaround for Rails not regocnizing Time.zone.now -> 'MSK' as valid time zone
  def set_time_zone
    Time.use_zone('Europe/Moscow') { yield }
  end
end
