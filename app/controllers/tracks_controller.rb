# -*- encoding : utf-8 -*-

class TracksController < ApplicationController

  before_filter :login_or_oauth_required
  before_filter :find_track, only: %[destroy]

  def create
    if @track = current_user.tracks.from_url(params[:url])
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

  def update
    current_user.tracks.find(params[:id]).reorder(params[:position].to_i)
    render(text: 'OK')
  end

  def index
    @tracks = Track.limit(50)
    respond_to do |format|
      format.html { render }
      format.json { render json: @tracks = Track.where(url: params[:url]) }
    end
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
