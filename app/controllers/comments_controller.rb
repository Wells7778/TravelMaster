class CommentsController < ApplicationController
  before_action :set_attraction
  before_action :set_comment



  def create
    @comment = @attraction.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to attraction_path(@attraction)
  end


  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def set_attraction
    @attraction = Attraction.find_by(id: params[:attraction_id])
  end

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end


end
