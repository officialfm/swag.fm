require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_add_favorite
    alice = users(:alice)
    old_favorites = alice.favorites.to_a
    favorite = Favorite.new(track: tracks(:slaugther_house))
    assert_difference('alice.favorites.count') { assert(alice.add_favorite(favorite)) }
    assert_equal([favorite] + old_favorites, alice.favorites.reload)
  end
end
