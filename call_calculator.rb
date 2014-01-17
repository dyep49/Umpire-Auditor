class CallCalculator


	def self.correct_call?(options)
		if (options[:description] == "Called Strike" || options[:description] == "Ball")
			CallCalculator.strike?(options) == options[:description]
		else
			nil
		end
	end

	def self.strike?(options)
		if CallCalculator.width_strike?(options) && CallCalculator.height_strike?(options)
			"Called Strike"
		else
			"Ball"
		end
	end

	def self.width_strike?(options)
		half_plate_width = (17.5/12)/2
		options[:x_location].to_f.abs < half_plate_width
	end

	def self.height_strike?(options)
		(options[:y_location] < options[:sz_top]) && (options[:y_location] > options[:sz_bottom])
	end

	def self.distance_miss(options)
		half_plate_width = (17.5/12)/2

		if options[:y_location] > options[:sz_top]
			distance_missed_y = (options[:y_location] - options[:sz_top]).round(2)
		elsif options[:y_location] < options[:sz_bottom]
			distance_missed_y = (options[:sz_bottom] - options[:y_location]).round(2)
		else
			distance_missed_y = 0
		end

		if options[:x_location].abs > half_plate_width
			distance_missed_x = (options[:x_location].abs - half_plate_width).round(2)
		else
			distance_missed_x = 0
		end

		total_distance_missed = distance_missed_y + distance_missed_x
		[distance_missed_x, distance_missed_y, total_distance_missed]
	end



end


