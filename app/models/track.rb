class Track < ActiveRecord::Base
  attr_accessible :url

  belongs_to :user

  ###################
  ### Validations ###
  ###################

  validate :user, presence: true

  #################
  ### Callbacks ###
  #################

  before_create :initialize_position

  #####################
  ### Class methods ###
  #####################

  def self.from_url(url)
    track = new(url: url) and track.fetch_metadata and track
  end

  ######################
  ### Public methods ###
  ######################

  def fetch_metadata
    require 'swag_fm'
    if track = SwagFm.official.track(resource_id, fields: 'cover,streaming')
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

  #######################
  ### Private methods ###
  #######################

  private

  def initialize_position
    self.position ||= user.tracks.count + 1
  end

end
