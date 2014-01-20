require_relative 'csvparser.rb'
require_relative 'seed_helper.rb'

def create_pitches_csv
	gids = SeedHelper.pull_gids("components/game/mlb/year_2013/")
	gids.each do |gid|
		CsvParser.parse_game_pitches(gid)
	end	
	puts "pitches.csv created!"
end


def create_umpires_csv
	umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/**/**/**/players.xml")
	puts "umpires.csv created!"
end


def create_games_csv
	gids = SeedHelper.pull_gids("components/game/mlb/year_2013/")
	gids.each do |gid|
		CsvParser.parse_game(gid)
	end
end


def create_teams_csv
	gids = SeedHelper.pull_gids("components/game/mlb/year_2013/")
	teams_array = []
	gids.each do |gid|
		two_team_array = CsvParser.parse_team(gid)
		home_team = two_team_array[0]
		away_team = two_team_array[1]
		unless teams_array.include?(home_team[:team_id])
			CSV.open("teams.csv", "a") do |csv|
				csv << [home_team[:team_id], home_team[:abbrev], home_team[:name_full], home_team[:division_id], home_team[:league_id], home_team[:code], home_team[:city], home_team[:name_brief]]
				teams_array << home_team[:team_id]
			end
		end
		unless teams_array.include?(away_team[:team_id])
			CSV.open("teams.csv", "a") do |csv|
				csv << [away_team[:team_id], away_team[:abbrev], away_team[:name_full], away_team[:division_id], away_team[:league_id], away_team[:code], away_team[:city], away_team[:name_brief]]
				teams_array << away_team[:team_id]
			end
		end
	end
end





