class CreateUser1s < ActiveRecord::Migration[5.0]
  def change
    create_table :user1s do |t|
      t.string :provider
      t.string :uid
      t.string :oauth_token
      t.datetime :oauth_expires_at

      t.timestamps
    end
  end
end
