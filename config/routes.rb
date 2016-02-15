Rails.application.routes.draw do

  # specific / named routes at top
  
  # resources in the middle

  resources :courses, only: [:index, :new, :create, :show, :edit, :update] do
    resources :tasks
  end

  resources :enrollments, only: [:index, :new, :create, :show]

  resources :students, only: [:index, :new, :create, :show, :edit, :update]

  # nonspecific / catch-all routes at the bottom
  root to: 'home#index'

end
