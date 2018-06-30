class AddUserRefToReservations < ActiveRecord::Migration[5.0]
  def change
    add_reference :reservations, :user, foreign_key: true
  end
end
