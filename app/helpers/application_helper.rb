module ApplicationHelper

  def logged_out
    if session[:user_id]
      redirect_to root_path, notice: 'You must be logged in before accessing this site.'
    end
  end

  def logged_in
    if session[:user_id].to_s != params[:id]
      redirect_to root_path, notice: "You do not have that authorization :p"
    end
  end

  def logged

  end

end
