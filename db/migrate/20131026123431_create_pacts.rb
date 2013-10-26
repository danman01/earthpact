class CreatePacts < ActiveRecord::Migration
  def change
    create_table :pacts do |t|
      t.boolean :agreed
      t.decimal :balance, :precision => 8, :scale => 2
      t.decimal :penalty, :precision => 8, :scale => 2
      t.references :user, index: true

      t.timestamps
    end
  end
end
