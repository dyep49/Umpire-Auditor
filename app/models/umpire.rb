class Umpire < ActiveRecord::Base
  has_many :games

  attr_accessible :name, :umpire_id
  validates_uniqueness_of :umpire_id


end
