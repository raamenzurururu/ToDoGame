Rails.application.routes.draw do
  namespace :v1 do
    resources :todos, only: [:create, :destroy]
    resources :rewards, only: [:create, :destroy, :update]
    resources :users, only: [:index, :create]
    get '/todos/:id', to: 'todos#complete'
  end
end
