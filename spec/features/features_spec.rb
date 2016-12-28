require "rails_helper"

describe "Integration tests" do
  let(:fresh_rate) { CBRateFinder.dollar }
  before { create(:exchange_rate) }

  describe "front page contains vueJS element with correct rate from the model" do
    specify do
      visit root_path
      expect(page.find('#rate_show')[:'data-rate']).to eq(fresh_rate.to_s)
    end
  end

  describe "correctly setting new rate in /admin changes rate on the front page" do
    specify do
      visit edit_exchange_rate_path
      fill_in "Rate", with: 123.45
      select "#{Time.current.year}", from: "exchange_rate_date_1i"
      select Time.current.strftime("%B"), from: "exchange_rate_date_2i"
      select "#{Time.current.day}", from: "exchange_rate_date_3i"
      select Time.current.in_time_zone('Europe/Moscow').hour.to_s.rjust(2, '0'),
            from: "exchange_rate_date_4i"
      select (Time.current + 1.minute).strftime("%M").to_i.to_s.rjust(2, '0'),
            from: "exchange_rate_date_5i"
      click_on "Set Forced Rate"
      visit root_path
      expect(page.find('#rate_show')[:'data-rate']).to eq("123.45")
    end
  end

end
