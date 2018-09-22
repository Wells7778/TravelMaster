class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(comment_params)

  end


  private
  def set_attraction
    @attraction = Attraction.find_by(id: params[:attraction_id])
  end

  def comment_params
    params.require(:comment).permit(:content, :images, :suggestion)
  end
end
