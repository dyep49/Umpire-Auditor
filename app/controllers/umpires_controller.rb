class UmpiresController < ApplicationController

def index
	umpire_info = Umpire.read_umpire_csv
	case params["sort"]
	when "total_calls" 
		umpire_array = umpire_info.sort_by{|k,v| v[2]}.reverse
	when "total_incorrect_calls"
		umpire_array = umpire_info.sort_by{|k,v| v[1]}.reverse
	when "total_correct_calls"
		umpire_array = umpire_info.sort_by{|k,v| v[0]}.reverse
	else
		umpire_array = umpire_info.sort_by{|k,v| v[3]}.reverse
	end
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
