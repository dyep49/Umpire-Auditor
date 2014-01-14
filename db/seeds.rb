# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require_relative '../dataparser.rb'


umpires = DataParser.umpire_seed_helper("components/game/mlb/year_2013/month_06/day_06/**/players.xml")

umpires.each do |umpire|
	new_ump = Umpire.new
	new_ump.name = umpire[0]
	new_ump.umpire_id = umpire[1]
	new_ump.save!
end

# File.open(file)
# 	umpire = DataParser.parse_umpire_file(file)
# 	new_umpire = Umpire.new
# 	new_umpire.name = umpire[0]
# 	new_umpire.umpire_id = umpire[1]
# 	Umpire.save!





#find_or_create_by_name