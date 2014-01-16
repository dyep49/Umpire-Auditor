class PitchesController < ApplicationController

# before_filter :authenticate_user!


def index
	binding.pry
	@worst_call = Pitch.worst_call(Pitch.all)
	@umpire = @worst_call.umpire
	@game = @worst_call.game
end


end