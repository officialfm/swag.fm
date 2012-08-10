class User < ActiveRecord::Base

  attr_accessible :email, :password
  has_secure_password
  has_many :tracks

end
