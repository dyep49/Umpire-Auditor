
require_relative '../dataparser.rb'
require_relative '../seed_helper.rb'



#SEEDS DATABASE WITH ALL RELEVANT DATA FROM 6/6/2013


#Creates umpires

#For all of 2013 uncomment...
umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/**/**/**/players.xml")


# umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/month_06/day_06/**/players.xml")

umpires.each do |umpire|
	begin
	new_ump = Umpire.new
	new_ump.name = umpire[0]
	new_ump.mlb_umpire_id = umpire[1]
	new_ump.save!
	puts "created new umpire"
	rescue
		puts "there's gonna be duplicates, obviously..."
	end
end

#Creates pitches for each individual game

# gids = SeedHelper.pull_gids("components/game/mlb/year_2013/month_06/day_06/")

#For all of 2013 uncomment...

gids = SeedHelper.pull_gids("components/game/mlb/year_2013/")

seeded_pitches = []
pitch_array =[]

n=0

gids.each do |gid|
	pitch_umpire = DataParser.parse_umpire(gid)[1] 
	pitch_array = []
	pitches = DataParser.parse_game_pitches(gid)
	  pitches.each do |pitch|
		new_pitch = Pitch.new
		new_pitch.description = pitch[:description]
		new_pitch.pid = pitch[:pid]
		new_pitch.gid = gid
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
		n+=1
		puts n
		pitch_array << new_pitch
		puts "new pitch created"
	end
	seeded_pitches << pitch_array
end

seeded_pitches << pitch_array

#Creates new games

seeded_games = []

gids.each do |gid|
	hash = DataParser.parse_game(gid)
	new_game = Game.new
	new_game.gid = gid
	new_game.home_team_id = hash[:home_team_id]
	new_game.away_team_id = hash[:away_team_id]
	new_game.mlb_umpire_id = hash[:mlb_umpire_id].to_i
	# new_game.pitches << Pitch.where(gid: gid)
	new_game.save!
	seeded_games << new_game
	puts "created new game"
end

i = 0

#Adds pitches to a game

seeded_games.each do |game|
	game.pitches << seeded_pitches[i]
	i += 1
	puts "pitches added to game"
end

#Adds a game to an umpire object

umpire_id_array = []

seeded_games.each do |game|
	mlb_umpire_id = game.mlb_umpire_id
	Umpire.where(mlb_umpire_id: mlb_umpire_id)[0].games << game
	puts "game added to umpire"
end


# umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/month_06/day_06/**/players.xml")

# umpires.each do |umpire|
# 	begin
# 		new_ump = Umpire.new
# 		new_ump.name = umpire[0]
# 		new_ump.mlb_umpire_id = umpire[1]
# 		new_ump.save!
# 		puts "THIS SHOULDN'T HAVE HAPPENED"
# 	rescue 
# 		puts "Duplicate Umpire"
# 	end
# end



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