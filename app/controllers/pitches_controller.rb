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

def show
	# binding.pry
	begin
		date_string = "#{params[:day]}-#{params[:month]}-#{params[:year]}"
		pitches = Pitch.where("gid LIKE ?", "%#{params[:year]}_#{params[:month]}_#{params[:day]}%")
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