class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.string :apartment_type
      t.string :payment_type
      t.date :arrival_date
      t.date :departure_date

      t.timestamps
    end
  end
end
