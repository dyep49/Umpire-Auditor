class Team < ActiveRecord::Base
	has_many :games
	has_many :pitchers

  def games
  	Game.where(home_team_id: self.team_id) + Game.where(away_team_id: self.team_id)
  end
end
