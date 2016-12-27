require 'rails_helper'

RSpec.describe ExchangeRatesController, type: :controller do
  describe "GET index" do
    let(:fresh_rate) { CBRateFinder.dollar }

    it "uses freshly scraped rate if the last known is outdated" do
      last_known = create(:exchange_rate, date: Time.current - 1.hour)
      get :index
      expect(assigns(:current_rate).rate).to eq(fresh_rate)
    end

    it "uses last known rate if the freshly scraped one is not different" do
      last_known = create(:exchange_rate, date: Time.current + 1.minute, rate: fresh_rate)
      get :index
      expect(assigns(:current_rate)).to eq(last_known)
    end
  end

  describe "PATCH update" do
    it "updates the most recent exchange rate" do
      ExchangeRate.create(rate: 150)
      patch :update, params: { exchange_rate: { date: Time.current + 1.minute, rate: 80 } }
      expect(ExchangeRate.last.rate).to eq(80)
      expect(response).to redirect_to(root_path)
    end

    it "goes back to form on failure" do
      ExchangeRate.create(rate: 150)
      patch :update, params: { exchange_rate: { date: Time.current - 1.minute, rate: 80 } }
      expect(ExchangeRate.last.rate).not_to eq(80)
      expect(response).to render_template(:edit)
    end
  end
end
