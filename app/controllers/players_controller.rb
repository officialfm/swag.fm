# -*- encoding : utf-8 -*-

class PlayersController < ApplicationController

  def create
    @player = Player.new(params[:player])
    if @player.save
      respond_to do |format|
        format.html { redirect_to '/' }
        format.json { render json: @player }
      end
    else
      render @player.errors, status: :unprocessable_entity
    end
  end

  def bookmarks
    @players = Player.find_by_url(params[:url])
    render json: @players
  end

end
