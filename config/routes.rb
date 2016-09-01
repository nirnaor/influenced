Rails.application.routes.draw do
  root to: 'home#start'
  get '/video', to: 'home#video'
  get '/influences', to: 'home#influences'
  get '/followers', to: 'home#followers'
end
