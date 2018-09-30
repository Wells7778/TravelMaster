class ReviewsController < ApplicationController
  before_action :set_attraction, except: [:new_one, :new_cone_create]
  before_action :set_review, only: [:index, :show, :edit, :update]
  before_action :set_all_names, only: [:new_one]

  def index
    @reviews = Review.where(status: "passed")
  end

  def show
  end

  def new
    @review = @attraction.reviews.new
  end

  def new_one
    @review = Review.new
  end

  def new_one_create
    @review = Review.new(review_params)
    @attraction = Attraction.where(name: new_one_params[:attraction_name]).first
    if @attraction.try(:reviews)
      @review.attraction_id = @attraction.id
      @review.user_id = current_user.id
      if @review.save
        flash[:notice] = "新增投稿成功，等待審核"
        redirect_to reviews_path
      else
        flash[:alert] = @review.errors.full_messages.to_sentence
        set_all_names
        render :new_one
      end
    else
      flash[:alert] = "景點讀取失敗"
      set_all_names
      render :new_one
    end
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

  def new_one_params
    params.require(:review).permit(:attraction_name, :title, :content, :suggestion, {images: []})
  end

  def set_all_names
    @all_names = []
    Attraction.all.each do |a|
      @all_names << a.name
    end
  end

end
