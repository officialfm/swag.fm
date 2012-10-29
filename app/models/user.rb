class User < ActiveRecord::Base

  attr_accessible :email, :password
  has_secure_password
  has_many :tracks, order: 'position'
  has_many :client_applications
  has_many :tokens, class_name: "OauthToken", order: "authorized_at desc", include: [:client_application]

  def name
    email.split('@').first
  end

  def add_track(track)
    if track.valid?
      User.transaction do
        tracks.update_all('position = position + 1')
        track.position = 1 and track.user = self
        track.save or raise ActiveRecord::Rollback
      end
    else
      false
    end
  end
end
