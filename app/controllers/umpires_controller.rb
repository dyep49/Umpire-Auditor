class UmpiresController < ApplicationController

def index
	binding.pry
	@umpire_array = Umpire.sort_by_performance(Umpire.all)
end


end
