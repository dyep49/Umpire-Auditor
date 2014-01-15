class CreatePitches < ActiveRecord::Migration
  def change
    create_table :pitches do |t|
      t.float :x_location
      t.float :y_location
      t.float :sz_top
      t.float :sz_bottom
      t.integer :pid
      t.integer :sv_id
      t.integer :pitcher_id
      t.integer :umpire_id
      t.timestamps
    end
  end
end
