BaseballProject::Application.routes.draw do
 
devise_for :users

root :to => "pitches#index"

resources :pitches
resources :favorites
resources :umpires
resources :pitchers
resources :games


end
