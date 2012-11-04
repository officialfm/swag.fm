class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :url, null: false
      t.string :cover_url, null: false
      t.string :stream_url, null: false
      t.integer :user_id, null: false
      t.integer :position, null: false
      t.timestamps
    end
  end
end
