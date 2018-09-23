class CommentsController < ApplicationController

  def create
    @attraction = Attraction.find(params[:attraction_id])
    @comment = @attraction.comments.build(comment_params)
    @comment.user = current_user
    @comment.save!
    redirect_to attraction_path(@attraction)
  end

  private

  def comment_params
    params.require(:comment).permit(:content)
  end

end
