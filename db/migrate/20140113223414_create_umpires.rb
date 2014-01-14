class CreateUmpires < ActiveRecord::Migration
  def change
    create_table :umpires do |t|
      t.string :name
      t.string :umpire_id, :unique => true
      t.timestamps
    end
  end
end
