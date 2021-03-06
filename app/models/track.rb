class Track < ActiveRecord::Base

  attr_accessible :url

  #################
  ### Relations ###
  #################

  has_many :favorites

  ###################
  ### Validations ###
  ###################

  validate :title, :artist, :duration, :url, :stream_url, :cover_url, presence: true

  #####################
  ### Class methods ###
  #####################

  def self.new_from_url(url)
    track = new(url: url) and track.fetch_metadata and track
  end

  ######################
  ### Public methods ###
  ######################

  def fetch_metadata
    if resolver = SwagFm::Resolver.new_from_url(url)
      self.cover_url = resolver.cover_url
      self.stream_url = resolver.stream_url
      self.duration = resolver.duration
      self.url = resolver.origin_url
      self.artist = resolver.artist
      self.title = resolver.title
    end
  end

  def resource_id
    url.split('/').last
  end

  def resource_type
    url.split('/')[-2]
  end

end
