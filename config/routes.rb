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
    root :to => "web#index"
    get "signup", :to => "users/registrations#new"
    get "login", :to => "users/sessions#new"
    delete "logout", :to => "users/sessions#destroy"
  end

  resource :users, only: [:edit, :update] do
    collection do
      get "cart", :to => "shopping_carts#index"
      post "cart/create", :to => "shopping_carts#create"
      delete "cart", :to => "shopping_carts#destroy"
      get "after_perchase", :to => "shopping_carts#after_perchase"
      delete "cart_destroy", :to => "shopping_carts#cart_destroy"
      delete "lesson_destroy", :to => "shopping_carts#lesson_destroy"
      get "mypage", :to => "users#mypage"
      get "mypage/edit", :to => "users#edit"
      put "mypage", :to => "users#update"
      get "mypage/edit_password", :to =>"users#edit_password"
      put "mypage/password", :to => "users#update_password"
      get "mypage/register_card", :to => "users#register_card"
      post "mypage/token", :to => "users#token"
      get "mypage/cart_history", :to => "users#cart_history_index", :as => "mypage_cart_histories"
      get "mypage/cart_history/:num", :to => "users#cart_history_show", :as => "mypage_cart_history"
    end
  end

  resources :lessons, only: [:index, :show]

  resources :reservations
  #いいね機能
  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'
  
  #検索機能
  get 'search' => 'searchs#search'
  get 'admins_profile/:id' => "searchs#admin_profile", as: "admin_profile"

  # chat機能
  get 'chattop/index'
  resources :rooms, :only => [:show, :create] do
    resources :messages, :only => [:create]
  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
