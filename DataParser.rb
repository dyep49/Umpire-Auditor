module DataParser 

FILE_BASE_PATH = 'components/game/mlb'

def base_folder_path(gid)
	year = gid[4..7]
	month = gid[9..10]
	day = gid [12..13]
	path = "#{FILE_BASE_PATH}/#{year}/#{month}/#{day}/#{gid}"
end

def parse_game_pitches(gid)
	path = base_folder_path(gid)
	files = Dir.glob("#{path}/inning/inning_[0-9]*.xml")
	pitches = []
	files.each do |file|
		pitches << parse_inning_pitches(file)
	end
	pitches
end


def parse_inning_pitches(file_path)
	f = File.open(file_path)
	doc = Nokogiri::XML(f)
	pitches = []
	parsed_pitches = doc.css('pitch')
	parsed_pitches.each do |pitch|
		pitches << parse_pitch(pitch.attributes)
	end
	pitches
end


def parse_pitch(pitch)
	des = pitch["des"].value
	id = pitch["id"].value
	px = pitch["px"].value
	pz = pitch["pz"].value
	sz_top = pitch["sz_top"].value
	sz_bot = pitch["sz_bot"].value
	sv_id = pitch["sv_id"].value
	pitch_characteristics = [des, id, px, pz, sz_top, sz_bot, sv_id]
end

def parse_game(gid)
	path = base_folder_path(gid)
	f = File.open("#{path}/game.xml")
	game = Nokogiri::XML(f)
	game_attributes = game.css('game')[0].children[1].attributes
	home_abbrev = game_attributes["abbrev"].value
	id = game_attributes["id"].value
	abbrev = game_attributes["abbrev"].value
	abbrev = game_attributes["abbrev"].value








end