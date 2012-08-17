class SessionController < ApplicationController
  def show
  end

  def create
    email, password = params[:session][:email], params[:session][:password]
    if self.current_user = User.find_by_email(email).try(:authenticate, password)
      respond_to do |format|
        format.html { redirect_to(current_user) }
        format.json { render json: {} }
      end
    else
      render(:show)
    end
  end

  def destroy
    self.current_user = nil
    redirect_to('/')
  end
end
