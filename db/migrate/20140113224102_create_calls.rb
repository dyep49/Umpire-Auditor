class CreateCalls < ActiveRecord::Migration
  def change
    create_table :calls do |t|
      t.integer :pitcher_id
      t.integer :umpire_id
      t.string :description
      t.boolean :correct_call
      t.float :distance_missed, :default => 0
      t.timestamps
    end
  end
end
