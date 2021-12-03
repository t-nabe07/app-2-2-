Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users

  resources :users,only: [:show,:index,:edit,:update] do
    #member do
      #get :follows, :followers
    #end
    #resource :relationships, only: [:create,:destroy]
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :books do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end

end