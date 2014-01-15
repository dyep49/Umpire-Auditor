class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :home_team_id
      t.integer :away_team_id
      t.integer :gid
      t.integer :umpire_id
      t.timestamps
    end
  end
end
