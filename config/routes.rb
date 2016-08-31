Rails.application.routes.draw do
  root to: 'home#start'
  get '/search', to: 'home#search'
  get '/influences', to: 'home#influences'
end
