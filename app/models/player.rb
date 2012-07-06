class Player < ActiveRecord::Base
  attr_accessible :url

  def resource_id
    url.split('/').last
  end

  def resource_type
    url.split('/')[-2]
  end
end
