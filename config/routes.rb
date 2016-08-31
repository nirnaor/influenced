Rails.application.routes.draw do
  root to: 'home#start'
  get 'home/start'

  get 'home/search'

  get 'home/influences'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
