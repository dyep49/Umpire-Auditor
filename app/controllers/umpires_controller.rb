class UmpiresController < ApplicationController

def index
	@umpire_array = Umpire.sort_by_performance(Umpire.all)
end

def show
	@umpire = Umpire.find(params[:id])


end


end
