Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }
  resources :events do
    post :assign_user, on: :member
    post :remove_user, on: :member
  end
  get 'welcome/index'
  root 'events#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
