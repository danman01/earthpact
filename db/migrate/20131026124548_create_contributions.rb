class CreateContributions < ActiveRecord::Migration
  def change
    create_table :contributions do |t|
      t.float :charity_split
      t.float :earthpact_split
      t.decimal :amount, :precision => 8, :scale => 2
      t.integer :last_four
      t.string :payment_provider
      t.references :user, index: true

      t.timestamps
    end
  end
end
