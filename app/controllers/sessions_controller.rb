class SessionsController < ApplicationController

  include ApplicationHelper

  before_action :logged_out, only: [:new, :create]

  before_action :logged_in_at_all, only: [:destroy]

  def new
    
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.password == params[:password]
      session[:user_id] = user.id
      flash[:notice] = "Log in successful."
    elsif user
      flash[:notice] = "Incorrect password."
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
