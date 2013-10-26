class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.datetime :start_day
      t.datetime :end_day
      t.decimal :total_contributed, :precision => 8, :scale => 2
      t.integer :total_used

      t.timestamps
    end
  end
end
