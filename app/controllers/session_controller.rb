class SessionController < ApplicationController
  def create
    if user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to(user)
    else
      render(:index)
    end
  end
end
