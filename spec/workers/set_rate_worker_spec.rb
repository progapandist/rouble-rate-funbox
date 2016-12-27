require 'rails_helper'

describe SetRateWorker do

  describe 'creating records' do
    let(:fresh_rate) { CBRateFinder.dollar }
    let(:worker) { SetRateWorker.new }

    it 'uses freshly scraped rate if the last known is outdated' do
      last_known = create(:exchange_rate, date: Time.current - 1.hour)
      worker.perform
      expect(ExchangeRate.last.rate).to eq(fresh_rate)
    end

    it 'uses last known rate if the freshly scraped one is not different' do
      last_known = create(:exchange_rate, date: Time.current - 1.hour, rate: fresh_rate)
      worker.perform
      expect(ExchangeRate.last).to eq(last_known)
    end
  end

  describe 'scheduling' do
    it 'will be scheduled hourly' do
      valid, invalid = times
      expect( next_occurrence ).to eq(valid)
      expect( next_occurrence ).not_to eq(invalid)
      Timecop.freeze(Time.zone.now + 1.hour)
      # Testing the past time is no longer valid
      expect( next_occurrence ).not_to eq(valid)
      valid, invalid = times
      expect( next_occurrence ).to eq(valid)
      expect( next_occurrence ).not_to eq(invalid)
    end
  end

  def next_occurrence
    SetRateWorker.schedule.next_occurrence.utc
  end

  def times(offset = 1.hour)
    valid = Time.current.beginning_of_hour + offset
    invalid = valid + 1.minute

    [valid, invalid]
  end
end
