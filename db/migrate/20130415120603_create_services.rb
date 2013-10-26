class CreateServices < ActiveRecord::Migration
  def change
    create_table :services do |t|
      t.references :user, index: true
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :access_token
      t.datetime :token_expires_at

      t.timestamps
    end
  end
end
