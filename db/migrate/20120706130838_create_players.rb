class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :url, null: false
      t.string :cover_url, null: false
      t.string :stream_url, null: false
      t.timestamps
    end
  end
end
