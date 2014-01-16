require 'nokogiri'
require 'open-uri'
require 'csv'

class CsvParser

FILE_BASE_PATH = 'components/game/mlb'

def self.parse_gid(file_path)
	f = File.open(file_path)
	doc = Nokogiri::XML(f)
	hash = Hash.from_xml(doc.to_s)
	gid = hash["game"]["id"]
end


def self.base_folder_path(gid)
	year = gid[0..3]
	month = gid[5..6]
	day = gid [8..9]
	path = "#{FILE_BASE_PATH}/year_#{year}/month_#{month}/day_#{day}/gid_#{gid}"
end

def self.parse_game_pitches(gid)
	path = base_folder_path(gid)
	files = Dir.glob("#{path}/inning/inning_[0-9]*.xml")
	pitches = []
	files.each do |file|
		CsvParser.parse_inning_pitches(file, gid)
	end
end


def self.parse_inning_pitches(file_path, gid)
	f = File.open(file_path)
	doc = Nokogiri::XML(f)
	pitches = []
	inning_number = file_path[-6..-1].scan(/\d+/)[0].to_i
	parsed_pitches = doc.css('pitch')
	parsed_pitches.each do |pitch|
		CsvParser.parse_pitch(pitch.attributes, gid)
		# pitch_info[:inning_number] = inning_number if pitch_info[:missing_data] == false
		# pitches << pitch_info
	end
end


def self.parse_pitch(pitch, gid)
	begin
		
		description = pitch["des"].value
		pid = pitch["id"].value
		x_location = pitch["px"].value
		y_location = pitch["pz"].value
		sz_top = pitch["sz_top"].value
		sz_bottom = pitch["sz_bot"].value
		sv_id = pitch["sv_id"].value
		type_id = pitch["type"].value
		CSV.open("pitches.csv", "a") do |csv|
		 csv << [gid, description, pid, x_location, y_location, sz_top, sz_bottom, sv_id, type_id, false]
		end
		puts "Pitch created"
	rescue 
		puts "UNABLE TO CREATE PITCH--------------------------------"
		 CSV.open("pitches.csv", "a") do |csv|
		 	csv << [gid, nil, nil, nil, nil, nil, nil, nil, nil, true]
		 end
	end
end


#--------------------------------------------------------------------------------

def self.parse_umpire(gid)
	path = DataParser.base_folder_path(gid)
	f = File.open("#{path}/players.xml")
	doc = Nokogiri::XML(f)
	hash = Hash.from_xml(doc.to_s)
	home_plate_umpire = hash["game"]["umpires"]["umpire"][0]
	umpire_name = home_plate_umpire["name"]
	mlb_umpire_id = home_plate_umpire["id"]
	[umpire_name, mlb_umpire_id]
end

def self.parse_umpire_file(file)
	f = File.open(file)
	doc = Nokogiri::XML(f)
	hash = Hash.from_xml(doc.to_s)
	home_plate_umpire = hash["game"]["umpires"]["umpire"][0]
	umpire_name = home_plate_umpire["name"]
	mlb_umpire_id = home_plate_umpire["id"]
	[umpire_name, mlb_umpire_id]
end

def self.umpire_seed_helper(file_search)
	umpire_array = []
	files = Dir.glob(file_search)
	puts files.empty?
	files.each do |file|
		umpire_array << DataParser.parse_umpire_file(file)
	end
	umpire_array
end




end