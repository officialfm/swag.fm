class Favorite < ActiveRecord::Base

  attr_accessible :track, :user, :position

  #################
  ### Relations ###
  #################

  belongs_to :user
  belongs_to :track
  belongs_to :from_user

  ###################
  ### Validations ###
  ###################

  validates :user, :track, :position, presence: true

  #####################
  ### Class methods ###
  #####################

  def self.new_from_url(url)
    new(track: Track.find_by_url(url) || Track.from_url(url))
  end

  def self.between(from, to)
    where('position BETWEEN ? AND ?', from, to)
  end

  ######################
  ### Public methods ###
  ######################

  def reorder(new_position)
    Favorite.transaction do
      if new_position < position
        user.favorites.between(new_position, position-1).update_all('position = position + 1')
      else
        user.favorites.between(position+1, new_position).update_all('position = position - 1')
      end
      update_attributes!(position: new_position)
    end
  end

end
