require 'spec_helper'
require_relative '../../lib/dataparser'

describe DataParser do 
	it 'should get basic game information' do
		VCR.use_cassette('game') do 
			# gid = DataParser.parse_gid
			game = DataParser.parse_game("2013_06_06_arimlb_slnmlb_1")
			game.home_abbrev == "STL"
			game.away_abbrev == "ARI"
		end
	end
end

