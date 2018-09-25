class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save!
    render :json => { :id => @comment.id }
    #redirect_to attraction_path(@attraction)
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :attraction_id)
  end

end
