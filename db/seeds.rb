%w(
  http://new.official.fm/tracks/2d8q
  http://new.official.fm/tracks/c9Zd
  http://new.official.fm/tracks/2g1w
  http://new.official.fm/playlists/1rp7
  http://new.official.fm/tracks/SuGB
  http://new.official.fm/tracks/7W5f
  http://new.official.fm/tracks/LxOu
  http://new.official.fm/tracks/9kAi
  http://new.official.fm/tracks/Gmdl
  http://new.official.fm/tracks/8DGT
  http://new.official.fm/tracks/O357
).each { |url| Player.create!(url: url) }
