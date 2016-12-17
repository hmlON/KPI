class Reservation < ApplicationRecord
  belongs_to :user;

  validates_presence_of :apartment_type, :payment_type, :arrival_date,
                        :departure_date
  validate :arrival_date_cannot_be_in_the_past
  validate :departure_date_is_later_than_arrival_date

  APARTMENT_TYPES = [
    'single_standart', 'single_standart_better', 'double_standart',
    'single_halfluxury', 'double_halfluxury', 'luxury'
  ]

  PAYMENT_TYPES = ['cash', 'credit card']

private

  def departure_date_is_later_than_arrival_date
    errors.add(:departure_date, 'has to be later then arrival date.') if departure_date < arrival_date
  end

  def arrival_date_cannot_be_in_the_past
    errors.add(:arrival_date, "can't be in the past.") if arrival_date < Date.current
  end
end
