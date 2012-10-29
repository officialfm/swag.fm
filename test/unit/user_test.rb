require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def test_add_track
    alice = users(:alice)
    previous_first_track = alice.tracks.first
    track = Track.new(url: 'http://api.official.fm/tracks/2d8q/stream')
    track.stream_url = 'http://api.official.fm/tracks/2d8q/stream'
    track.cover_url = 'http://cdn.official.fm/medias/pictures/vn/vnlN_medium.jpg'
    assert_difference('alice.tracks.count') { alice.add_track(track) }
    assert_equal(2, previous_first_track.reload.position)
  end
end
