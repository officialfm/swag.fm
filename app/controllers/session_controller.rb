class SessionController < ApplicationController
  def show
  end

  def create
    if user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to(user)
    else
      render(:show)
    end
  end

  def destroy
    self.current_user = nil
    redirect_to('/')
  end
end
