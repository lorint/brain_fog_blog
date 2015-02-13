class SessionsController < ApplicationController
  def new
  	@user = User.new
  end

  def create
  	u = User.where(email: params[:user][:email]).first
  	if u != nil && u.authenticate(params[:user][:password])
  		session["user_id"] = u.id.to_s
  		redirect_to posts_path(user_id: u.id)
  	else
  		redirect_to new_sessions_path
  	end
  end

  def destroy
  	session.destroy
  	redirect_to new_sessions_path
  end
end
