class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :amount_used
      t.text :description
      t.references :user, index: true
      t.references :week

      t.timestamps
    end
  end
end
