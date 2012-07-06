# -*- encoding : utf-8 -*-

class PlayersController < ApplicationController

  def create
    @player = Player.new(params[:player])
    if @player.save
      redirect_to '/'
    else
      render @player.errors, status: :unprocessable_entity
    end
  end

end
