class UsersController < ApplicationController
  def index
    @players = Player.all
  end
end
