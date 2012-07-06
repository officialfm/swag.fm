# -*- encoding : utf-8 -*-

class PlayersController < ApplicationController

  def create
    @player = Player.new(params[:player])
    if @player.save
      @players = Player.all
      render template: 'users/index'
    else
      render @player.errors, status: :unprocessable_entity
    end
  end

end
