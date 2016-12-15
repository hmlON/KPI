class Reservation < ApplicationRecord
  validates_presence_of :apartment_type,
                        :payment_type,
                        :arrival_date,
                        :departure_date

  APARTMENT_TYPES = [
    'single_standart', 'single_standart_better', 'double_standart',
    'single_halfluxury', 'double_halfluxury', 'luxury'
  ]

  PAYMENT_TYPES = ['cash', 'credit card']
end
