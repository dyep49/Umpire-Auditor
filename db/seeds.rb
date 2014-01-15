
require_relative '../dataparser.rb'
require_relative '../seed_helper.rb'


#SEEDS DATABASE WITH ALL RELEVANT DATA FROM 6/6/2013


#SEEDS UMPIRES

umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/month_06/day_06/**/players.xml")

umpires.each do |umpire|
	new_ump = Umpire.new
	new_ump.name = umpire[0]
	new_ump.umpire_id = umpire[1]
	new_ump.save!
	puts "created new umpire"
end

#SEEDS GAMES

gids = SeedHelper.pull_gids("components/game/mlb/year_2013/month_06/day_06/")

gids.each do |gid|
	hash = DataParser.parse_game(gid)
	new_game = Game.new
	new_game.gid = gid
	new_game.home_team_id = hash[:home_team_id]
	new_game.away_team_id = hash[:away_team_id]
	new_game.umpire_id = hash[:umpire_id].to_i
	new_game.save!
	puts "created new game"
end

#SEEDS PITCHES

gids.each do |gid|
	pitch_umpire = DataParser.parse_umpire(gid)[1] 
	# pitcher_id = 
	pitches = DataParser.parse_game_pitches(gid)
		pitches.each do |pitch|
			new_pitch = Pitch.new
			new_pitch.description = pitch[0]
			new_pitch.pid = pitch[1]
			new_pitch.x_location = pitch[2]
			new_pitch.y_location = pitch[3]
			new_pitch.sz_top = pitch[4]
			new_pitch.sz_bottom = pitch[5]
			new_pitch.sv_id = pitch[6]
			new_pitch.type = pitch[7]
			new_pitch.umpire_id = pitch_umpire
			if (new_pitch.description == "Called Strike" || new_pitch.description == "Ball")
				new_pitch.correct_call = new_pitch.correct_call? 
				if new_pitch.description == "Called Strike"
					new_pitch.distance_miss
				end
			end
			new_pitch.save!
			puts "new pitch created"
		end
end





# File.open(file)
# 	umpire = DataParser.parse_umpire_file(file)
# 	new_umpire = Umpire.new
# 	new_umpire.name = umpire[0]
# 	new_umpire.umpire_id = umpire[1]
# 	Umpire.save!

# respone = HTTParty.get("http://www.brooksbaseball.net/pfxVB/pfx.php?s_type=3&sp_type=1&year=2013&month=6&day=15&pitchSel=150302&game=gid_2013_06_15_arimlb_sdnmlb_1/&prevGame=gid_2013_06_15_arimlb_sdnmlb_1/&prevDate=615&batterX=3")
# doc = Nokogiri::HTML(response)
# image = parsed.css('a')[21].children[0].attributes["src"].value
# link = "http://www.brooksbaseball.net/pfxVB/cache/" + image



#find_or_create_by_name