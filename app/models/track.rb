class Track < ActiveRecord::Base
  attr_accessible :url

  belongs_to :user

  ###################
  ### Validations ###
  ###################

  validate :user, presence: true

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
    if resolver = SwagFm::Resolver.new_from_url(url)
      self.cover_url = resolver.cover_url
      self.stream_url = resolver.stream_url
      self.duration = resolver.duration
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
