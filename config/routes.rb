Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :movies
  post '/movies/search_tmdb'
  root :to => redirect('/movies')
  
end
