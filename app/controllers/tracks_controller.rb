# -*- encoding : utf-8 -*-

class TracksController < ApplicationController

  before_filter :find_track, only: %[destroy]

  def create
    if @track = current_user.tracks.from_url(params[:player][:url])
      if @track.save
        respond_to do |format|
          format.html { render(layout: false)}
          format.json { render json: @track }
        end
      else
        render @track.errors, status: :unprocessable_entity
      end
    else
      render text: 'This track does not exist.', status: :unprocessable_entity
    end
  end

  def index
    @tracks = Track.where(url: params[:url])
    render json: @tracks
  end

  def destroy
    @track.destroy
    render json: {}
  end

  private

  def find_track
    @track = Track.find(params[:id])
  end

end
