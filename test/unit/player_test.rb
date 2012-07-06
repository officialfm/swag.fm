require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  def test_resource_id
    player = Player.new(url: 'http://new.official.fm/playlists/1rp7')
    assert_equal('1rp7', player.resource_id)
    refute(player.track_id)
  end

  def test_resource_type
    assert_equal('tracks', Player.new(url: 'http://new.official.fm/tracks/SuGB').resource_type)
    assert_equal('playlists', Player.new(url: 'http://new.official.fm/playlists/1rp7').resource_type)
  end
end
