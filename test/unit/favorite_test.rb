require 'test_helper'

class FavoriteTest < ActiveSupport::TestCase
  def test_new_from_url_when_track_exists
    assert_equal(tracks(:je_ne_sais_quoi), Favorite.new_from_url('http://official.fm/tracks/2d8q').track)
  end

  def test_new_from_url_when_track_does_not_exist
    Track.expects(new_from_url: track = Track.new)
    assert_equal(track, Favorite.new_from_url('http://official.fm/tracks/dB3C').track)
  end

  def test_reorder_before
    alice = users(:bob)
    alice.add_favorite(favorite3 = Favorite.new_from_url('http://official.fm/tracks/2d8q'))
    alice.add_favorite(favorite2 = Favorite.new_from_url('http://official.fm/tracks/Dxt5'))
    alice.add_favorite(favorite1 = Favorite.new_from_url('http://official.fm/tracks/7p4a'))
    assert_equal(1, favorite1.reload.position)
    assert_equal(2, favorite2.reload.position)
    assert_equal(3, favorite3.reload.position)
    favorite3.reload.reorder(2)
    assert_equal(1, favorite1.reload.position)
    assert_equal(2, favorite3.reload.position)
    assert_equal(3, favorite2.reload.position)
  end

  def test_reorder_after
    alice = users(:bob)
    alice.add_favorite(favorite3 = Favorite.new_from_url('http://official.fm/tracks/2d8q'))
    alice.add_favorite(favorite2 = Favorite.new_from_url('http://official.fm/tracks/Dxt5'))
    alice.add_favorite(favorite1 = Favorite.new_from_url('http://official.fm/tracks/7p4a'))
    assert_equal(1, favorite1.reload.position)
    assert_equal(2, favorite2.reload.position)
    assert_equal(3, favorite3.reload.position)
    favorite1.reload.reorder(2)
    assert_equal(1, favorite2.reload.position)
    assert_equal(2, favorite1.reload.position)
    assert_equal(3, favorite3.reload.position)
  end
end
