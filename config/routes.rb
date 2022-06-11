Rails.application.routes.draw do

   # 利用者用

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do

    root to: "homes#top"
    get "about" => "homes#about", as: "about"

    resources :articles do
      resources :comments, only: [:create, :destroy]
      resource :like, only: [:create, :destroy]
    end

    get "users/my_page/:id" => "users#show", as: "my_page"
    get "users/unsubscribe/:id" => "users#unsubscribe", as: "unsubscribe"
    patch "users/withdraw" => "users#withdraw"
    resources :users, only: [:edit, :update, :show] do
      resource :relationship, only: [:create, :destroy]
      get "followings" => "relationships#followings", as: "followings"
      get "followers" => "relationships#followers", as: "followers"
    end

    resources :groups, only: [:index, :new, :show, :edit, :create, :update, :destroy] do
      resources :chats, only:[:create, :destroy]
      resource :group_user, onyl: [:create, :destroy]
    end

    resources :notifications, only: [:index]

    get "searches/search" => "searches#search", as: "search"

    post "contacts/confirm" => "contacts#confirm"
    get "contacts/thanks" => "contacts#thanks"
    resources :contacts, only: [:create, :new]

  end



  # 管理者用

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  namespace :admin do

    resources :users, only: [:index, :show, :edit, :update]

    resources :articles, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end

    resources :groups, only: [:index, :show, :destroy]

  end


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
