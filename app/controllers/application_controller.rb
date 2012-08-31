class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user

  def current_user=(user)
    session[:user_id] = (@current_user = user).try(:id)
  end

  def login_required
    #TODO
  end

  def logged_in?
    current_user
  end
end
