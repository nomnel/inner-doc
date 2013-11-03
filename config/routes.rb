InnerDoc::Application.routes.draw do
  root 'users#new'

  resources :users
end
