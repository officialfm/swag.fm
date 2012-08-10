require 'foreign_key'

class CreateTracks < ActiveRecord::Migration
  include ForeignKey

  def change
    create_table :tracks do |t|
      t.string :url, null: false
      t.string :cover_url, null: false
      t.string :stream_url, null: false
      t.timestamps
    end
    # add_foreign_key :tracks, :user_id, :users
  end
end
