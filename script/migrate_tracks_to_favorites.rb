Favorite.delete_all

for track in Track.all
  Favorite.create!(track: track, user: track.user, position: track.position)
end

puts "Track count #{Track.count}, favorite count #{Favorite.count}"
