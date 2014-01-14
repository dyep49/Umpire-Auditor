require 'spec_helper'
require_relative '../../lib/dataparser'

describe DataParser do 
	it 'should parse local game information' do
		file_path = "components/game/mlb/year_2013/month_06/day_06/gid_2013_06_06_arimlb_slnmlb_1"  
		gid = DataParser.parse_gid(file_path)
		game = DataParser.parse_game(gid)
		game.home_abbrev.should == "STL"
		game.away_abbrev.should == "ARI"
	end
	it 'should parse all the pitches in a game' do 
		pitches = DataParser.parse_game_pitches("2013_06_06_arimlb_slnmlb_1")
		pitches.count.should == 340
		pitches[0].should == ["Called Strike", "347", "-0.77", "2.81", "3.29", "1.66", "130606_195635"]
	end
	it 'should parse the home plate umpire' do 
		umpire = DataParser.parse_umpire("2013_06_06_arimlb_slnmlb_1")
		umpire.should == ["Angel Hernandez", "427220"]
	end
end

