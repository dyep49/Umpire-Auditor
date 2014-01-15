class Pitch < ActiveRecord::Base
	belongs_to :game

	attr_accessible :total_distance_missed, :distance_missed_x, :distance_missed_y, :description, :x_location, :y_location, :sz_top, :sz_bottom, :type
	
	def initialize(options = {})
		@description = options[:description]
		@type = options[:type]
		@x_location = options[:x_location]
		@y_location = options[:y_location]
		@sz_top = options[:sz_top]
		@sz_bottom = options[:sz_bottom]

		# array = distance_miss
		# @distance_missed_x = array[0]
		# @distance_missed_y = array[1]
		# puts @distance_missed_y

		# @distance_missed_x = options[:distance_missed_x]
		# @distance_missed_y = options[:distance_missed_y]
		# @total_distance_missed = options[:total_distance_missed]
	end

	def strike?
		if width_strike? && height_strike?
			"Called Strike"
		else
			"Ball"
		end
	end

	def correct_call?
		strike? == @description
	end

	def width_strike?
		half_plate_width = (17.5/12)/2
		@x_location.abs < half_plate_width 
	end

	def height_strike?
		(@y_location < @sz_top) && (@y_location > @sz_bottom)
	end

	def distance_miss
		half_plate_width = (17.5/12)/2

		if @y_location > @sz_top
			@distance_missed_y = @y_location - @sz_top
		elsif @y_location < @sz_bottom 
			@distance_missed_y = @sz_bottom - @y_location
		else
			@distance_missed_y = 0
		end

		if @x_location.abs > half_plate_width
			@distance_missed_x = @x_location.abs - half_plate_width
		else
			@distance_missed_x = 0
		end

		@distance_missed_y


	end

end
