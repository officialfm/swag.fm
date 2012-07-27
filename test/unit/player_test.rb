require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def test_resource_id
    assert_equal('1rp7', Player.new(url: 'http://official.fm/playlists/1rp7').resource_id)
  end

  def test_resource_type
    assert_equal('tracks', Player.new(url: 'http://official.fm/tracks/SuGB').resource_type)
    assert_equal('playlists', Player.new(url: 'http://official.fm/playlists/1rp7').resource_type)
  end
end
