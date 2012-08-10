class UsersController < ApplicationController

  def new
  end

  def create
    redirect_to(User.create!(params[:user]))
  end

  def show
  end

  def index
    @tracks = Track.all
  end
end
