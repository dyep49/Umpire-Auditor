require_relative 'csvparser.rb'
require_relative 'seed_helper.rb'

def create_pitches_csv

	gids = SeedHelper.pull_gids("components/game/mlb/year_2013/")

	gids.each do |gid|
		CsvParser.parse_game_pitches(gid)
	end	

	puts "CSV File Created!"

end


def create_umpires_csv
	umpires = SeedHelper.umpire_seed_helper("components/game/mlb/year_2013/**/**/**/players.xml")
end
