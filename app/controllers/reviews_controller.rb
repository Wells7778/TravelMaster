class ReviewsController < ApplicationController
  before_action :set_attraction
  before_action :set_review, only: [:index, :show, :edit, :update]

  def index
    @reviews = Review.where(status: "passed")
  end

  def show
  end

  def new
    @review = @attraction.reviews.new
  end

  def create
    @review = @attraction.reviews.build(review_params)
    @review.user_id = current_user.id
    if @review.save
      flash[:notice] = "新增投稿成功，等待審核"
      redirect_to attraction_path(@attraction)
    else
      flash[:alert] = @review.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @review = Review.find_by(id: params[:id])
    if @review.status == "pending" && @review.update(review_params)
      flash[:notice] = "新增投稿成功，等待審核"
      redirect_to attraction_path(@attraction)
    else
      flash[:alert] = @review.errors.full_messages.to_sentence
      render :new
    end
  end


  private
  def set_attraction
    @attraction = Attraction.find_by(id: params[:attraction_id])
  end

  def set_review
    @review = Review.find_by(id: params[:id])
  end

  def review_params
    params.require(:review).permit(:title, :content, :suggestion, {images: []})
  end
end
