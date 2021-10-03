Rails.application.routes.draw do
  get 'users/index'
  get "login" => "users#login_form"
  post "login" => "users#login"
  post "logout"  => "users#logout"

  get 'posts/index' => "posts#index"
  get "users/:id" => "users#show"
  get "/signup" => "users#new"
  post "users/create" => "users#create"
  get "users/:id/edit" => "users#edit"
  post "users/:id/update" => "users#update"
  get "users/:id/likes" => "users#likes"

  get "posts/new" => "posts#new"
  get "posts/:id" => "posts#show"
  post "posts/create" => "posts#create" #フォームの値を受け取るときはpost
  get "posts/:id/edit" => "posts#edit"
  post "posts/:id/update" => "posts#update"
  post "posts/:id/destroy" => "posts#destroy"

  post "likes/:post_id/create" => "likes#create"
  post "likes/:post_id/destroy" => "likes#destroy"

  get "/" => "home#top"

  get "about" => "home#about" 

  get "books/index" => "books#index"
  get "books/create" => "books#create"
  get "books/show" => "books#show"
  post "books/update" => "books#update"
  
  resources :home
  root 'home#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
