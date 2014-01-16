class Game < ActiveRecord::Base
attr_accessible :home_team_id, :away_team_id, :mlb_umpire_id, :gid, :pitches

  belongs_to :team
  belongs_to :umpire
  has_many :pitches






end


