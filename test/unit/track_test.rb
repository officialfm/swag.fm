require 'test_helper'

class TrackTest < ActiveSupport::TestCase
  def test_resource_id
    assert_equal('2d8q', Track.new(url: 'http://official.fm/tracks/2d8q').resource_id)
  end

  def test_resource_type
    assert_equal('tracks', Track.new(url: 'http://official.fm/tracks/SuGB').resource_type)
    assert_equal('playlists', Track.new(url: 'http://official.fm/playlists/1rp7').resource_type)
  end
end
