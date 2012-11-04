require 'foreign_key'

class CreateFavorites < ActiveRecord::Migration
  include ForeignKey

  def up
    create_table :favorites do |t|
      t.integer :user_id, null: false
      t.integer :track_id, null: false
      t.integer :position, null: false
      t.timestamps
    end

    add_index :favorites, [:user_id, :position]
    add_index :favorites, :created_at

    add_foreign_key :favorites, :user_id, :users
    add_foreign_key :favorites, :track_id, :tracks
  end

  def down
    drop_table :favorites
  end
end
