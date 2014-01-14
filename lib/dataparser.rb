class DataParser 

attr_accessor :home_abbrev, :away_abbrev

FILE_BASE_PATH = 'components/game/mlb'

def initialize(options)
	@home_abbrev = options[:home_abbrev]
	@away_abbrev = options[:away_abbrev]
end

def self.parse_gid(file_path)
	f = File.open("#{file_path}/gamecenter.xml")
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
		pitches << DataParser.parse_inning_pitches(file)
	end
	pitches.flatten(1)
end


def self.parse_inning_pitches(file_path)
	f = File.open(file_path)
	doc = Nokogiri::XML(f)
	pitches = []
	parsed_pitches = doc.css('pitch')
	parsed_pitches.each do |pitch|
		pitches << DataParser.parse_pitch(pitch.attributes)
	end
	pitches
end


def self.parse_pitch(pitch)
	des = pitch["des"].value
	id = pitch["id"].value
	px = pitch["px"].value
	pz = pitch["pz"].value
	sz_top = pitch["sz_top"].value
	sz_bot = pitch["sz_bot"].value
	sv_id = pitch["sv_id"].value
	pitch_characteristics = [des, id, px, pz, sz_top, sz_bot, sv_id]
end

def self.parse_game(gid)
	path = base_folder_path(gid)
	f = File.open("#{path}/game.xml")
	doc = Nokogiri::XML(f)
	hash = Hash.from_xml(doc.to_s)
	new({
	home_abbrev: hash["game"]["team"].first["abbrev"],
	home_id: hash["game"]["team"].first["id"],
	home_name_full: hash["game"]["team"].first["name_full"],
	home_division_id: hash["game"]["team"].first["division_id"],
	home_league_id: hash["game"]["team"].first["league_id"],
	home_code: hash["game"]["team"].first["code"],
	away_abbrev: hash["game"]["team"].last["abbrev"],
	away_id: hash["game"]["team"].last["id"],
	away_name_full: hash["game"]["team"].last["name_full"],
	away_division_id: hash["game"]["team"].last["division_id"],
	away_league_id: hash["game"]["team"].last["league_id"],
	away_code: hash["game"]["team"].last["code"]
	})
end


def self.parse_umpire(gid)
	path = DataParser.base_folder_path(gid)
	f = File.open("#{path}/players.xml")
	doc = Nokogiri::XML(f)
	hash = Hash.from_xml(doc.to_s)
	home_plate_umpire = hash["game"]["umpires"]["umpire"][0]
	umpire_name = home_plate_umpire["name"]
	umpire_id = home_plate_umpire["id"]
	[umpire_name, umpire_id]
end


end