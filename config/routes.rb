Rails.application.routes.draw do
  get '/blogs/new' => 'blog#new', :as => 'new_blog'
  get '/blogs' => 'blog#index', :as => 'blogs'
  get '/blogs/:id' => 'blog#show', :as => 'blog'
  root 'blog#index'
end
