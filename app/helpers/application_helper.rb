module ApplicationHelper
  def logged_in?
    unless session[:user_id]
      redirect_to login_path, notice: 'You must log in before accessing this site.'
    end
  end
end
