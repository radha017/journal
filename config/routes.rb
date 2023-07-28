Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "pages#home", as: "home"
  get "/dashboard" => "pages#dashboard", as: "dashboard"

  get "/categories" => "categories#index", as: "categories"
  get "/categories/new" => "categories#new", as: "new_category"
  post "/categories" => "categories#create", as: "create_category"
  get "/categories/:id/edit" => "categories#edit", as: "edit_category"
  patch "/categories/:id" => "categories#update", as: "update_category"
  delete "/categories/:id" => "categories#destroy", as: "destroy_category"
  get "/categories/:id" => "categories#show", as: "show_category"

  get "/tasks" => "tasks#index", as: "tasks"
  get "/tasks/new" => "tasks#new", as: "new_task"
  post "/tasks" => "tasks#create", as: "create_task"
  get '/tasks/:id' => 'tasks#show', as: 'show_task'
  get '/tasks/:id/edit' => 'tasks#edit', as: 'edit_task'
  patch '/tasks/:id' => 'tasks#update', as: 'update_task'
  delete '/tasks/:id' => 'tasks#destroy', as: 'destroy_task'

  
end
