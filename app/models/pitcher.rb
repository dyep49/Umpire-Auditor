class Pitcher < ActiveRecord::Base
  belongs_to :team
  has_many :games

  # attr_accessible :title, :body


end
