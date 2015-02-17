class CommentsController < ApplicationController
  # Consider that we don't need a new action here
  # because the post has the form that submits a new comment
  def create
    if current_user != nil
      comment = Comment.new(params.require(:comment).permit(:title, :comment_text))
      comment.user_id = current_user.id
      if comment.save
        redirect_to posts_path
      end
    end
  end

  def destroy
    # Note that with edit, destroy, show, and update
    # the ID comes from the route!!!!! such as:
    #   delete 'thingers/:id' => 'thingers#destroy'
    comment = Comment.where(id: params[:id]).first
    comment.destroy
    redirect_to posts_path
  end
end
