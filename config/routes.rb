Rails.application.routes.draw do

  get 'relationships/followings'
  get 'relationships/followers'
  root 'homes#top'
  get 'home/about' => 'homes#about'
  devise_for :users
  get "search" => "searches#search"

  resources :users,only: [:show,:index,:edit,:update] do
    resource :relationships, only: [:create, :destroy]
    get :followings, on: :member
    get :followers, on: :member
  end

  resources :books do
    resource :favorites,only:[:create,:destroy]
    resources :book_comments, only:[:create,:destroy]
  end

  resources :groups, only:[:new, :create, :edit, :update, :show, :index, :destroy]

end