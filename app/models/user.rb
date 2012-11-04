class User < ActiveRecord::Base

  ##################
  ### Attributes ###
  ##################

  attr_accessible :email, :password
  has_secure_password

  #################
  ### Relations ###
  #################

  has_many :favorites, order: 'position'
  has_many :client_applications
  has_many :tokens, class_name: "OauthToken", order: "authorized_at desc", include: [:client_application]

  ######################
  ### Public methods ###
  ######################

  def name
    email.split('@').first
  end

  def add_favorite(favorite)
    User.transaction do
      favorites.update_all('position = position + 1')
      favorite.position = 1 and favorite.user = self
      favorite.save or raise ActiveRecord::Rollback
    end
  end
end
