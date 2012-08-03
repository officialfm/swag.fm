%w(
  http://official.fm/tracks/2d8q
  http://official.fm/tracks/13QT
  http://official.fm/tracks/7p4a
  http://official.fm/tracks/Dxt5
  http://official.fm/tracks/c9Zd
  http://official.fm/tracks/OwvI
).each { |url| Track.from_url(url).save!  }
