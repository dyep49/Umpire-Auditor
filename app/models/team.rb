class Team < ActiveRecord::Base
	has_many :games
	has_many :pitchers

  # attr_accessible :title, :body
end
