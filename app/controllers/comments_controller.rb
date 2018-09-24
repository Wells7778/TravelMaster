class CommentsController < ApplicationController
  before_action :set_attraction
  before_action :set_comment, only: [:show, :edit, :update]
  def show
  end

  def new
    @comment = @attraction.comments.new
  end

  def create
    @comment = @attraction.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "新增投稿成功，等待審核"
      redirect_to attraction_path(@attraction)
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      render :new
    end
  end

  def edit
  end

  def update
    @comment = Comment.find_by(id: params[:id])
    if @comment.status == "pending" && @comment.update(comment_params)
      flash[:notice] = "新增投稿成功，等待審核"
      redirect_to attraction_path(@attraction)
    else
      flash[:alert] = @comment.errors.full_messages.to_sentence
      render :new
    end
  end


  private
  def set_attraction
    @attraction = Attraction.find_by(id: params[:attraction_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :suggestion, {images: []})
  end
end
