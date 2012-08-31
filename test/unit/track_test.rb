require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def test_resource_id
    assert_equal('2d8q', Track.new(url: 'http://official.fm/tracks/2d8q').resource_id)
  end

  def test_resource_type
    assert_equal('tracks', Track.new(url: 'http://official.fm/tracks/SuGB').resource_type)
    assert_equal('playlists', Track.new(url: 'http://official.fm/playlists/1rp7').resource_type)
  end

  def test_reorder_before
    tracks(:guilty_conscience).reorder(2)
    assert_equal(1, tracks(:je_ne_sais_quoi).position)
    assert_equal(2, tracks(:guilty_conscience).position)
    assert_equal(3, tracks(:slaugther_house).position)
  end

  def test_reorder_after
    tracks(:je_ne_sais_quoi).reorder(2)
    assert_equal(1, tracks(:slaugther_house).position)
    assert_equal(2, tracks(:je_ne_sais_quoi).position)
    assert_equal(3, tracks(:guilty_conscience).position)
  end
end
