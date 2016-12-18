class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]

  def index
    @reviews = Review.all.order(created_at: :desc).includes(:user)
    @review = Review.new
  end

  def create
    @review = Review.new(review_params)

    if @review.save
      respond_to do |format|
        format.html { redirect_to reviews_path, notice: 'Review successfully created.' }
        format.js
      end
    else
      render :index
    end
  end

  def destroy
    @review = Review.find(params[:id])
    @review.destroy

    respond_to do |format|
      format.html { redirect_to reviews_path }
      format.js
    end
  end

private

  def review_params
    params.require(:review)
      .permit(:text, :rating)
      .merge(user_id: current_user.id)
  end

end
