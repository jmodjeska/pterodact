Rails.application.routes.draw do

  # specific / named routes at top

  get 'sign_in', to: 'sessions#new', as: 'sign_in'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'landing', to: 'pages#landing', as: 'landing'

  # resources in the middle

  resources :courses, only: [:index, :new, :create, :show, :edit, :update] do
    resources :offer_dates
  end

  resources :enrollments, only: [:index, :new, :create, :show]
  resources :students, only: [:index, :new, :create, :show, :edit, :update] do
    collection { post :import }
  end
  resources :users, only: [:index, :new, :create, :show, :edit, :update]

  # Translations example. Not in use. Probably won't work on Heroku.
  # resources :translations, only: [:index, :create]

  # nonspecific / catch-all routes at the bottom

  root to: 'home#index'
end
