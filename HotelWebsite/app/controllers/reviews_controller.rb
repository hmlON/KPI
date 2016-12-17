class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @reviews = Review.all.order(rating: :desc).includes(:user)
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      redirect_to reviews_path, notice: 'Review successfully created.'
    else
      render :index
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    redirect_to reviews_path
  end

private

  def review_params
    params.require(:review)
      .permit(:text, :rating)
      .merge(user_id: current_user.id)
  end

end
