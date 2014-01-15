require 'spec_helper'

describe Pitch do
	describe "given a ball, called a strike" do
 		before do 
  		description = "Called Strike"
  		x_location = -0.21
  		y_location = 1.1
  		sz_top = 3.65
  		sz_bottom = 1.75
  		@pitch = Pitch.new(description: description, y_location: y_location, x_location: x_location, sz_top: sz_top, sz_bottom: sz_bottom)
  	end
  	describe "when asked if correct call" do
 			it "should take the pitch and" do
  			@pitch.correct_call?.should == false
  			@pitch.distance_miss.should == 0.65
  		end
		end
	end
	describe "given a strike, called a strike" do 
		before do
			description = "Called Strike"
  		x_location = -0.21
  		y_location = 1.9
  		sz_top = 3.65
  		sz_bottom = 1.75
  		@pitch = Pitch.new({description: description, y_location: y_location, x_location: x_location, sz_top: sz_top, sz_bottom: sz_bottom})
  	end
		describe "when asked if correct call" do
			it "should take the pitch and" do
				@pitch.correct_call?.should == true
			end
		end
	end
	describe "given a ball, called a strike" do 
		before do
			description = "Called Strike"
  		x_location = -0.21
  		y_location = 1.1
  		sz_top = 3.65
  		sz_bottom = 1.75
  		@pitch = Pitch.new({description: description, y_location: y_location, x_location: x_location, sz_top: sz_top, sz_bottom: sz_bottom})
  	end
		describe "when asked if correct call" do
			it "should take the pitch and" do
				@pitch.correct_call?.should == false
			end
		end
	end
	describe "given a ball, called a ball" do 
		before do
			description = "Ball"
  		x_location = -0.21
  		y_location = 1.1
  		sz_top = 3.65
  		sz_bottom = 1.75
  		@pitch = Pitch.new({description: description, y_location: y_location, x_location: x_location, sz_top: sz_top, sz_bottom: sz_bottom})
  	end
		describe "when asked if correct call" do
			it "should take the pitch and" do
				@pitch.correct_call?.should == true
			end
		end
	end
end
