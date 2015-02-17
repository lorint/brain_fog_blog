class PostsController < ApplicationController
  def index
    # Let's see if they're passing a user_id to us
    # in the custom params (the querystring of the URL)
    if params[:user_id] != nil
      # Yup, so we'll try to filter by this ID
      @posts = Post.where(user_id: params[:user_id])
    else
      # Nope, so let's just show them ALL posts
      @posts = Post.all
    end
  end

  def new
    @post = Post.new
  end

  def create
    if current_user != nil
      post = Post.new(params.require(:post).permit(:title, :post_text))
      post.user_id = current_user.id
      if post.save
        redirect_to posts_path(user_id: current_user.id)
      else
        redirect_to new_post_path
      end
    end
  end

  def destroy
    # Note that with edit, destroy, show, and update
    # the ID comes from the route!!!!! such as:
    #   delete 'thingers/:id' => 'thingers#destroy'
    post = Post.where(id: params[:id]).first
    post.destroy
    redirect_to posts_path
  end

  def show
    @post = Post.where(id: params[:id]).first
  end
end
