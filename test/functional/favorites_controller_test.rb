require 'test_helper'

class FavoritesControllerTest < ActionController::TestCase
  def test_create_when_track_already_exists
    login(bob = users(:bob))
    assert_no_difference('Track.count') do
      assert_difference('bob.favorites.count') do
        post(:create, url: 'http://official.fm/tracks/2d8q')
        assert_response(:success)
      end
    end
  end
end
