class Admin::ReviewsController < Admin::BaseController
  before_action :set_review, except: :index
  def index
    @reviews = Review.all
  end

  def update
    @review = Review.find_by(id: params[:id])
    @review.update(status: params[:status])
      flash[:notice] = "#{@review.title}權限更新為#{params[:status]}"
      redirect_to admin_reviews_path
  end

  def destroy
    @review.destroy
    redirect_to admin_reviews_path
  end

  private
  def set_review
    @review = Review.find_by(id: params[:id])
  end


end
