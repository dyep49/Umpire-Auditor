class UmpiresController < ApplicationController

def index
	# @umpire_array = Umpire.sort_by_performance(Umpire.all)
	umpire_info = Umpire.read_umpire_csv
	umpire_array = umpire_info.sort_by{|k,v| v[3]}.reverse
	@umpire_hash = {}
	umpire_array.each do |umpire|
		@umpire_hash[umpire[0]] = umpire[1]
	end
	@umpires = []
	umpire_array.each do |umpire|
		@umpires << Umpire.find_by_name(umpire[0])
	end
end

def show
	@umpire = Umpire.find(params[:id])
end


end
