class CommentsController < ApplicationController
 before_filter :authenticate_user!


 def index
    @comments = Comment.all 
 end

  def new
    @comment = Comment.new
    redirect_to user_path(current_user.id)
  end

  def create
    new_comment = params.require(:comment).permit(:title, :type, :content, :activity_id)
    @comment = Comment.create(new_comment)
    id = current_user.id
    redirect_to user_path(current_user.id)
  end
  
  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = Comment.find(params[:id])
    update_params = params.require(:comment).permit(:title, :type, :content, :activity_id) 
    @comment.update_attributes(update_params)
    redirect_to user_path(current_user.id)
  end

  def destroy
    comment = Comment.find(params[:id])
    comment.delete
    redirect_to user_path(current_user.id)
  end



end
