class User < ActiveRecord::Base

  attr_accessible :email, :password
  has_secure_password

end
