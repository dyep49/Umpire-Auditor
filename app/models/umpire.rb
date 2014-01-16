class Umpire < ActiveRecord::Base
  has_many :games

  attr_accessible :name, :mlb_umpire_id, :games
  # validates_uniqueness_of :umpire_id


end
