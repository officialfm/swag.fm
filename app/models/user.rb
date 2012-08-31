class User < ActiveRecord::Base

  attr_accessible :email, :password
  has_secure_password
  has_many :tracks, order: 'position'
  has_many :client_applications
  has_many :tokens, class_name: "OauthToken", order: "authorized_at desc", include: [:client_application]

end
