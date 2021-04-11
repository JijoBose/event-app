Rails.application.routes.draw do
  resources :users
  resources :events do
  	member do
      post :assign_user
    end
  end
  get 'welcome/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
