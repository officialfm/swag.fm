class RemoveUnusedTracksColumns < ActiveRecord::Migration
  def change
    remove_column :tracks, :user_id
    remove_column :tracks, :position
  end
end
