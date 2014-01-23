require_relative 'seed_helper.rb'
require_relative 'dataparser.rb'
require_relative 'csvparser.rb'


#Gotta get a gid o this

def parse_game
	f = File.open(file_path)
	doc = Nokogiri::XML(f)
	game_id = ??????
	parse_atbat = doc.css('atbat')
	parse_atbat.each do |atbat|
		batter_id = atbat["batter"]
		pitcher_id = atbat["pitcher"]


#to access pitches inside an atbat
	atbat.children.each do |pitch|
		



	end