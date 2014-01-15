
require_relative '../dataparser.rb'


#SEEDS DATABASE WITH ALL RELEVANT DATA FROM 6/6/2013


umpires = DataParser.umpire_seed_helper("components/game/mlb/year_2013/month_06/day_06/**/players.xml")

umpires.each do |umpire|
	new_ump = Umpire.new
	new_ump.name = umpire[0]
	new_ump.umpire_id = umpire[1]
	new_ump.save!
	puts "created new umpire"
end

gids = DataParser.pull_gids("components/game/mlb/year_2013/month_06/day_06/")

gids.each do |gid|
	hash = DataParser.parse_game(gid)
	new_game = Game.new
	puts gid
	new_game.gid = gid
	new_game.home_team_id = hash[:home_team_id]
	new_game.away_team_id = hash[:away_team_id]
	new_game.umpire_id = hash[:umpire_id].to_i
	new_game.save!
	puts "created new game"
end




# File.open(file)
# 	umpire = DataParser.parse_umpire_file(file)
# 	new_umpire = Umpire.new
# 	new_umpire.name = umpire[0]
# 	new_umpire.umpire_id = umpire[1]
# 	Umpire.save!





#find_or_create_by_name