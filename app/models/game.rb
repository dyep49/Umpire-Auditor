class Game < ActiveRecord::Base
attr_accessible :home_team_id, :away_team_id, :mlb_umpire_id, :gid, :pitches

belongs_to :team
belongs_to :umpire
has_many :pitches

def pitches
	gid = self.gid
	Pitch.where(gid: gid)
end

def umpire
	Umpire.where(mlb_umpire_id: self.mlb_umpire_id)
end

def home_team
	home_team_id = self.home_team_id
	Team.find_by_team_id(home_team_id)
end

def away_team
	away_team_id = self.away_team_id
	Team.find_by_team_id(away_team_id)
end

def self.most_recent
	gid = Game.all.sort_by(&:gid).last.gid
	year = gid[0..3]
	month = gid[5..6]
	day = gid[8..9]
	"#{day}-#{month}-#{year}"
end

end
