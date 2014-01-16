require_relative 'dataparser.rb'
# require_relative 'app/models/game.rb'

class SeedHelper

def self.umpire_seed_helper(file_search)
	umpire_array = []
	files = Dir.glob(file_search)
	puts files.empty?
	files.each do |file|
		umpire_array << DataParser.parse_umpire_file(file)
	end
	umpire_array
end

def self.pull_gids(file_path)
	gid_array = []
	files = Dir.glob("#{file_path}**/gamecenter.xml")
	files.each do |file|
		gid_array << DataParser.parse_gid(file)
	end
	gid_array
end

# def self.populate_game(game, hash, gid)
# 	game.gid = gid
# 	game.home_team_id = hash[:home_team_id]
# 	game.away_team_id = hash[:away_team_id]
# 	game.umpire_id = hash[:umpire_id].to_i
# end

def self.create_pitch(pitch, gid, pitch_umpire)
	new_pitch = Pitch.new
		new_pitch.description = pitch[:description]
		new_pitch.pid = pitch[:pid]
		new_pitch.gid = gid
		# new_pitch.inning_number = pitch[:inning_number]
		new_pitch.x_location = pitch[:x_location]
		new_pitch.y_location = pitch[:y_location]
		new_pitch.sz_top = pitch[:sz_top]
		new_pitch.sz_bottom = pitch[:sz_bottom]
		new_pitch.sv_id = pitch[:sv_id]
		new_pitch.type_id = pitch[:type_id]
		new_pitch.missing_data = pitch[:missing_data]
		new_pitch.mlb_umpire_id = pitch_umpire
		if (new_pitch.description == "Called Strike" || new_pitch.description == "Ball")
			new_pitch.correct_call = new_pitch.correct_call? 
			if new_pitch.description == "Called Strike"
				new_pitch.distance_miss
			end
		end
		new_pitch.save!
		new_pitch
end


end