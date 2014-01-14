class Umpire < ActiveRecord::Base
  attr_accessible :name, :umpire_id
  validates_uniqueness_of :umpire_id
end
