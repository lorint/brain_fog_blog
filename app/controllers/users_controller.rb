class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	user = User.new(params.require(:user).permit(:email, :image, :password, :password_confirmation))
  	if user.save
  		session["user_id"] = user.id.to_s
  		redirect_to posts_path
  	else
  		redirect_to new_user_path
  	end
  end

  def edit
    @user = User.where(id: params[:id]).first
  end

  def update
    user = User.where(id: params[:id]).first
    if user.update(params.require(:user).permit(:email, :image, :password, :password_confirmation))
      redirect_to users_path
    else
      redirect_to edit_user_path(user)
    end
  end
end
