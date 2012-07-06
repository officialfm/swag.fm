# -*- encoding : utf-8 -*-

class PlayersControllerController < ApplicationController

  def create
    @player = Player.new(params[:player])
    if @player.save
      render json: @player
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

end
