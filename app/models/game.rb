class Game < ActiveRecord::Base
  belongs_to :umpire
  belongs_to :team
  has_many :pitches
end
