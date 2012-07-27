class Player < ActiveRecord::Base
  attr_accessible :url

  #####################
  ### Class methods ###
  #####################

  def self.from_url(url)
    player = new(url: url) and player.fetch_metadata and player
  end

  ######################
  ### Public methods ###
  ######################

  def fetch_metadata
    require 'swag_fm'
    if track = SwagFm.official.track(resource_id, fields: 'cover')
      self.cover_url = track.cover.urls.medium
      self.stream_url = track.streaming.http
    end
  end

  def resource_id
    url.split('/').last
  end

  def resource_type
    url.split('/')[-2]
  end
end
