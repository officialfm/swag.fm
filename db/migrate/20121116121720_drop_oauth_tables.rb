class DropOauthTables < ActiveRecord::Migration
  def change
    drop_table :client_applications
    drop_table :oauth_tokens
    drop_table :oauth_nonces
  end
end
