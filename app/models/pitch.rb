class Pitch < ActiveRecord::Base
	belongs_to :game

	attr_accessible :description, :x_location, :y_location, :sz_top, :sz_bottom, :type
	
	def initialize(options = {})
		@description = options[:description]
		@type = options[:type]
		@x_location = options[:x_location]
		@y_location = options[:y_location]
		@sz_top = options[:sz_top]
		@sz_bottom = options[:sz_bottom]
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



end
