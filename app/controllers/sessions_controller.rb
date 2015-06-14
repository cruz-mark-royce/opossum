class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      flash[:notice] = "Log in successful."
    elsif user
      flash[:notice] = "Password incorrect."
    else
      flash[:notice] = "ACCESS DENIED"
    end
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Log out successful."
  end
end
