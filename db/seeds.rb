%w(
  http://official.fm/tracks/2d8q
  http://official.fm/tracks/c9Zd
  http://official.fm/tracks/2g1w
  http://official.fm/playlists/1rp7
  http://official.fm/tracks/SuGB
  http://official.fm/tracks/7W5f
  http://official.fm/tracks/LxOu
  http://official.fm/tracks/9kAi
  http://official.fm/tracks/Gmdl
  http://official.fm/tracks/8DGT
  http://official.fm/tracks/O357
).each { |url| Player.create!(url: url) }
