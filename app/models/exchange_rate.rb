class ExchangeRate < ApplicationRecord
  validates :rate, presence: true
  validate :date, :date_cannot_be_the_past, on: :update

  def date_cannot_be_the_past
    if date < Time.now
      errors.add(:date, "can not be in the past")
    end
  end
end
