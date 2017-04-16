class ReviewsController < ApplicationController

  include ApplicationHelper

  before_action :authorize

  def create
    @product = Product.find_by(id: params[:product_id])
    user_id = current_user.id
    # user_id = User.find(session[:user_id]).id
    puts "------User ID inside review create is #{user_id}--------"
    @review = @product.reviews.new({
      user_id: user_id,
      description: review_params["description"],
      rating: review_params["rating"]
      });
    if @review.save
      flash[:notice] = nil
      redirect_to product_path(@product)
    else
      flash[:notice] = @review.errors.full_messages
      render "products/show"
    end
  end

  def remove_review
    @review = Review.destroy(params[:review_id].to_i)
    redirect_to :back
  end

  private
  def review_params
    params.require(:review).permit(:description, :rating)
  end

end
