class UmpiresController < ApplicationController

def index
	# @umpire_array = Umpire.sort_by_performance(Umpire.all)
	@umpire_hash = Umpire.read_umpire_csv
	# umpire_info = umpire_hash.values
	@umpires = []
	@umpire_hash.keys.each do |key|
		@umpires << Umpire.find_by_name(key)
	end
end

def show
	@umpire = Umpire.find(params[:id])
	# binding.pry
end


end
