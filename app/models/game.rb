class Game < ActiveRecord::Base
	attr_accessible :home_team_id, :away_team_id, :umpire_id

  belongs_to :team
  belongs_to :umpire
  has_many :pitches
end


