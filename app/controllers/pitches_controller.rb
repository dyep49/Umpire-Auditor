class PitchesController < ApplicationController

before_filter :authenticate_user!


def index
	@worst_call = Pitch.worst_call(Pitch.all)
	@umpire = @worst_call.umpire
	@game = @worst_call.game
	binding.pry
end


end