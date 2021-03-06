class ReviewsController < ApplicationController

  def create
    user = User.find_by(id: safe_review_params[:user_id])
    review = user.reviews.create(to: safe_review_params[:to], event_id: safe_review_params[:event_id],
                       rating: safe_review_params[:rating], text: safe_review_params[:text])

    if review.save
      flash[:notice] = I18n.t('flash.flash_reviews_notice')
      redirect_to user_dashboard_path(user.id)
    else
      flash[:alert] = review.errors.full_messages
      redirect_to user_dashboard_path(user.id)
    end
  end

  private

  def safe_review_params
    params.require(:review).permit(:user_id, :to, :event_id, :rating, :text)
  end
end
