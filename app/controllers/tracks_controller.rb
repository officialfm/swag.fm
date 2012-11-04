# -*- encoding : utf-8 -*-

class TracksController < ApplicationController

  def create
    @user = current_user
    @track = Track.from_url(params[:url])
    if current_user.add_track(@track)
      if @track.save
        respond_to do |format|
          format.html { render(layout: false) }
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
    @tracks = Track.limit(100).order('created_at DESC')
    respond_to do |format|
      format.html { render }
      format.json { render json: @tracks = Track.where(url: params[:url]) }
    end
  end

end
