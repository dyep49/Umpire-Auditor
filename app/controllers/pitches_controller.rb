class PitchesController < ApplicationController

# before_filter :authenticate_user!


def index
	@pitches_status = "active"
	most_recent_date = Game.most_recent
	@date = Date.parse(most_recent_date)
	pitches = Pitch.where(date_string: most_recent_date)
	@worst_call = Pitch.worst_call(pitches)
	@umpire = @worst_call.game.umpire[0]
	@game = Game.where(gid: @worst_call.gid)[0]
	# binding.pry
end

def show
	@pitches_status = "active"
	# binding.pry
	begin
		month = params["date"][0..1]
		day = params["date"][3..4]
		year = params["date"][6..9]
		date_string = "#{day}-#{month}-#{year}"
		pitches = Pitch.where("gid LIKE ?", "%#{year}_#{month}_#{day}%")
		@date = Date.parse(date_string)
		# binding.pry
		@worst_call = Pitch.worst_call(pitches)
		@umpire = @worst_call.game.umpire[0]
		@game = Game.where(gid: @worst_call.gid)[0]
	rescue
		redirect_to pitches_path
	end

end


end