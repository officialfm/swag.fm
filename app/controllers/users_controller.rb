class UsersController < ApplicationController

  def new
  end

  def create
    redirect_to(self.current_user = User.create!(params[:user]))
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end
end
