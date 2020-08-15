Rails.application.routes.draw do
  namespace :v1 do
    resources :todos, only: [:create, :destroy, :update]
    resources :rewards, only: [:create, :destroy, :update]
    resources :users, only: [:index, :create]
    get '/todos/:id', to: 'todos#complete'
    get '/rewards/:id', to: 'rewards#complete'
    patch '/todos', to: 'todos#sort'
    patch '/rewards', to: 'rewards#sort'
  end
end
