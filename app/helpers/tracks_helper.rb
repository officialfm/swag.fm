module TracksHelper
  def track_tooltip(track)
    "#{track.artist} - #{track.title}"
  end
end
