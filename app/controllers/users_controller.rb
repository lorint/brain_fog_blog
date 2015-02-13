class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def new
  	@user = User.new
  end

  def create
  	user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
  	if user.save
  		session["user_id"] = user.id.to_s
  		redirect_to posts_path
  	else
  		redirect_to new_user_path
  	end
  end
end
