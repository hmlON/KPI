class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.create(reservation_params)
    redirect_to root_path, notice: "You successfully sent your reservation."
  end

private

  def reservation_params
    params.require(:reservation).permit(:apartment_type,
                                        :payment_type,
                                        :arrival_date,
                                        :departure_date)
  end

end
