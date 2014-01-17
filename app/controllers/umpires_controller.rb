class UmpiresController < ApplicationController

def index
	@umpire_array = Umpire.sort_by_performance(Umpire.all)
end


end
