class AddTitleAndArtistToTracks < ActiveRecord::Migration
  def change
    add_column :tracks, :title, :string
    add_column :tracks, :artist, :string
  end
end
