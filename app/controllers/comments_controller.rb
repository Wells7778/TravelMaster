class CommentsController < ApplicationController

  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.save!
    @visited = current_user.has_passed_review?(comment_params[:attraction_id])
    render :json => {:c_content =>@comment.content, :c_id => @comment.id, :c_user => current_user.name, :visited => @visited }
    #redirect_to attraction_path(@attraction)
  end

  def destroy
    @comment = Comment.find(comment_params[:attraction_id])
    @comment.destroy
    render :json => {:c_id => @comment.id}
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :attraction_id)
  end

end
