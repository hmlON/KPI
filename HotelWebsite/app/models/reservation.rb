class Reservation < ApplicationRecord
  validates_presence_of :apartment_type,
                        :payment_type,
                        :arrival_date,
                        :departure_date
  # validates :departure_date_is_later_than_arrival_date

  APARTMENT_TYPES = [
    'single_standart', 'single_standart_better', 'double_standart',
    'single_halfluxury', 'double_halfluxury', 'luxury'
  ]

  PAYMENT_TYPES = ['cash', 'credit card']

private

  def departure_date_is_later_than_arrival_date
    departure_date < arrival_date
  end
end
