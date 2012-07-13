class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :url, null: false
      t.string :steam_url, null: false
      t.string :picture_url, null: false
      t.timestamps
    end
  end
end
