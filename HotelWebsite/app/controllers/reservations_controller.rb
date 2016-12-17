class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def new
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    if @reservation.save
      redirect_to root_path, notice: "You have successfully sent your reservation. We will contact you in 2 hours."
    else
      flash.now[:alert] = @reservation.errors.full_messages.join(' ')
      render :new
    end
  end

private

  def reservation_params
    params.require(:reservation)
      .permit(:apartment_type,
              :payment_type,
              :arrival_date,
              :departure_date)
      .merge(user_id: current_user.id)
  end

end
