class UmpiresController < ApplicationController

def index
	@total_calls = 'asc'
	@total_incorrect_calls = 'asc'
	@total_correct_calls = 'asc'
	@correct_calls = 'asc'

	umpire_info = Umpire.read_umpire_csv
	case params["sort"]
	when "total_calls" 
		umpire_array = umpire_info.sort_by{|k,v| v[2]}
		if params["order"] == "desc"
			@total_calls = "asc"
		else
			umpire_array.reverse!
			@total_calls = "desc"
		end
	when "total_incorrect_calls"
		umpire_array = umpire_info.sort_by{|k,v| v[1]}
		if params["order"] == "desc"
			@total_incorrect_calls = "asc"
		else
			umpire_array.reverse!
			@total_incorrect_calls = "desc"
		end
	when "total_correct_calls"
		umpire_array = umpire_info.sort_by{|k,v| v[0]}
		if params["order"] == "desc"
			@total_correct_calls = "asc"
		else
			umpire_array.reverse!
			@total_correct_calls = "desc"
		end
	else
		umpire_array = umpire_info.sort_by{|k,v| v[3]}
		if params["order"] == "desc"
			@correct_calls = "asc"
		else
			puts "i'm here"
			umpire_array.reverse!
			@correct_calls = "desc"
		end
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
