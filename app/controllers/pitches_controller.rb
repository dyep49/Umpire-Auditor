class PitchesController < ApplicationController

# before_filter :authenticate_user!


def index
	# binding.pry
	most_recent_date = Game.most_recent
	@date = Date.parse(most_recent_date)
	pitches = Pitch.where(date_string: most_recent_date)
	@worst_call = Pitch.worst_call(pitches)
	@umpire = @worst_call.game.umpire[0]
	@game = Game.where(gid: @worst_call.gid)[0]
	# binding.pry
end


end