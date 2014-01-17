BaseballProject::Application.routes.draw do
 
devise_for :users

root :to => "pitches#index"

get '/pitches/year/:year/month/:month/day/:day', to: 'pitches#show'


resources :pitches
resources :favorites
resources :umpires
resources :pitchers
resources :games


end
