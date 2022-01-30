Rails.application.routes.draw do
  devise_for :admins, :controllers => {
    :registrations => 'admins/registrations',
    :sessions => 'admins/sessions',
    :passwords => 'admins/passwords',
    :unlocks => 'admins/unlocks',
  }
  devise_scope :admin do
    get "dashboard", :to => "dashboard#index"
    get "dashboard/signup", :to => "admins/registrations#new"
    post "dashboard/login", :to => "admins/sessions#new"
    delete "dashboard/logout", :to => "admins/sessions#destroy"
  end
  
  resource :admin, only: [:edit, :update] do
    collection do
      get "edit_profile", :to => "admins#edit_profile"
      get "edit_account", :to => "admins#edit_account"
    end
  end

  namespace :dashboard do
    resources :lessons
  end

  devise_for :users, :controllers => {
    :registrations => 'users/registrations',
    :sessions => 'users/sessions',
    :passwords => 'users/passwords',
    :unlocks => 'users/unlocks',
  }

  devise_scope :user do
    root :to => "lessons#index"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  resources :lessons, only: [:index, :show]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
