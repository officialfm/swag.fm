# -*- encoding : utf-8 -*-

class PlayersController < ApplicationController

  before_filter :find_player, only: %[destroy]

  def create
    if @player = Player.from_url(params[:player][:url])
      if @player.save
        respond_to do |format|
          format.html { redirect_to '/' }
          format.json { render json: @player }
        end
      else
        render @player.errors, status: :unprocessable_entity
      end
    else
      render text: 'This track does not exist.', status: :unprocessable_entity
    end
  end

  def index
    @players = Player.where(url: params[:url])
    render json: @players
  end

  def destroy
    @player.destroy
    render json: {}
  end

  private

  def find_player
    @player = Player.find(params[:id])
  end

end
