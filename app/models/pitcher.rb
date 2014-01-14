class Pitcher < ActiveRecord::Base
  has_many :games

  # attr_accessible :title, :body


end
