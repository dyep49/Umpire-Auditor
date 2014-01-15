class Pitch < ActiveRecord::Base
	belongs_to :game

	attr_accessible :total_distance_missed, :distance_missed_x, :distance_missed_y, :description, :x_location, :y_location, :sz_top, :sz_bottom, :type


	#Returns called strike if pitch in strike zone, even if that's not actual call by umpire
	def strike?
		if self.width_strike? && self.height_strike?
			"Called Strike"
		else
			"Ball"
		end
	end

	def correct_call?
		self.strike? == self.description
	end

	def width_strike?
		half_plate_width = (17.5/12)/2
		self.x_location.abs < half_plate_width 
	end

	def height_strike?
		(self.y_location < self.sz_top) && (self.y_location > self.sz_bottom)
	end

	def distance_miss
		half_plate_width = (17.5/12)/2

		if self.y_location > self.sz_top
			self.distance_missed_y = (self.y_location - self.sz_top).round(2)
		elsif self.y_location < self.sz_bottom 
			self.distance_missed_y = (self.sz_bottom - self.y_location).round(2)
		else
			self.distance_missed_y = 0
		end

		if self.x_location.abs > half_plate_width
			self.distance_missed_x = (self.x_location.abs - half_plate_width).round(2)
		else
			self.distance_missed_x = 0
		end

		self.total_distance_missed = self.distance_missed_y + self.distance_missed_x
	end

end
