class UsersController < ApplicationController

  def new
  end

  def create
    redirect_to(self.current_user = User.create!(params[:user]))
  end

  def show
    current_user
    @tracks = User.find(params[:id]).tracks
  end
end
