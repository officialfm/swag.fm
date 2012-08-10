require 'test_helper'

class TracksControllerTest < ActionController::TestCase
  def test_create
    login(users(:alice))
    assert_difference('Track.count') do
      post(:create, player: {url: 'http://official.fm/tracks/Dxt5'})
    end
    assert_response(:success)
  end
end
