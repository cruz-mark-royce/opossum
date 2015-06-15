module ApplicationHelper
  def logged_in
    unless session[:user_id]
      redirect_to login_path, notice: 'You must be logged in before accessig this site.'
    end
  end

  def not_logged_in
    unless session[:user_id]
      redirect_to login_path, notice: 'Action denied.'
    end

  end

end
