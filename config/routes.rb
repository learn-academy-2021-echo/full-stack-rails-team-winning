Rails.application.routes.draw do
  patch '/blogs/:id' => 'blog#update'
  get '/blogs' => 'blog#index', :as => 'blogs'
  get '/blogs/new' => 'blog#new', :as => 'new_blog'
  post '/blogs' => 'blog#create'
  get '/blogs/:id/edit' => 'blog#edit', :as => 'edit_blog'
  get '/blogs/:id' => 'blog#show', :as => 'blog'
  root 'blog#index'
end
