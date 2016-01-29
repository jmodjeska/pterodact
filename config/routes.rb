Rails.application.routes.draw do

  # specific / named routes at top
  
  # resources in the middle
  resources :courses, only: [:index]
  resources :students, only: [:index]

  # nonspecific / catch-all routes at the bottom
  root to: 'home#index'

end
