class UsersController < ApplicationController
  def index
    @tracks = Track.all
  end
end
