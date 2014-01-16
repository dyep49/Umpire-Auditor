require 'spec_helper'

describe UsersController do 
	describe "Given a user" do 
		before do 
			@user = User.create!(email: "test@example.com", password: "passwordpassword")
			@user.favorites = Favorite.new(team: "Baltimore Orioles")
		end
		describe "When not logged in" do 
			it "should redirect to users index" do 
				get :index
				response.should redirect_to(new_user_session_path)
			end
		end
		describe "When logged in" do 
			before do 
				sign_in @user
				redirect_to(favorites_path)
			end
			it "should show the Baltimore Orioles" do 
				get :favorites
				assigns(:users).should = @user.favorites
			end
		end
	end
end
