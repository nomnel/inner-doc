InnerDoc::Application.routes.draw do
  root 'users#new'

  get 'signin'  => 'sessions#new',     as: :signin
  get 'signout' => 'sessions#destroy', as: :signout
  resources :sessions, only: :create

  resources :users
end
