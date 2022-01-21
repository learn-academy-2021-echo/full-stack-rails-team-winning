## Challenges

#### As a developer, I have been commissioned to create an application where a user can see and create blog posts.

#### As a developer, I can create a full-stack Rails application.

```Shell
$ rails new my_app -d postgresql -T
$ cd my_app
$ rails db:create
$ rails s
```

#### As a developer, my blog post can have a title and content.

```Shell
$ rails g model Blog title:string content:text
$ rails c
```

#### As a developer, I can add new blog posts directly to my database.

```Shell
$ Blog.create title:'My First Blog Post', content:'This is my first blog entry. Today I learned about full-stack rails and it has gotten me a little confused, but
it is okay!'

$ Blog.create title:'My Second Blog Post', content:'This is my second blog post. Today I am testing out multiple blog posts and seeing how they display on my blog!
```

#### As a user, I can see all the blog titles listed on the home page of the application.

```Ruby
def index
  @blog = Blog.all
end
```

```Ruby
root 'blog#index'
```

```Ruby
get '/blogs' => 'blog#index', :as => 'blogs'
```

```Ruby
# index.html.erb
<h1>My Blog</h1>
<br />
<% @blog.reverse.map do |blog| %>
<h2><%= link_to blog.title, blog_path(blog) %></h2>
<p><%= blog.content[0,20] %>...</p>
<% end %>
```

#### As a user, I can click on the title of a blog and be routed to a page where I see the title and content of the blog post I selected.

#### As a user, I can navigate from the show page back to the home page.

```Ruby
def show
  @blog = Blog.find(params[:id])
end
```

```Ruby
get '/blogs/:id' => 'blog#show', :as => 'blog'
```

#### As a user, I can navigate from the show page back to the home page.

```Ruby
# show.html.erb
<h1><%= @blog.title %></h1>
<p><%= @blog.content %></p>
<p><%= link_to 'Back to all blogs', blogs_path %></p>
```

```Ruby
get '/blogs/:id' => 'blog#show', :as => 'blog'
```

#### As a user, I see a form where I can create a new blog post.

```Ruby
def new
  @blog = Blog.new
end
```

```Ruby
get '/blogs/new' => 'blog#new', :as => 'new_blog'
```

```Ruby
<h1>Add a New Blog Post</h1>
<%= form_with model: @blog, method: :path do |form| %> <%= form.label :title %>
<%= form.text_field :title %>

<br />
<%= form.label :content %> <%= form.text_field :content %>

<br />
<%= form.submit 'Add Blog' %> <% end %>
```

#### As a user, I can click a button that will take me from the home page to a page where I can create a blog post.

```Ruby
<%= link_to blog.title, blog_path(blog) %>
```

#### As a user, I can navigate from the form back to the home page.

```Ruby
<%= link_to 'Return to All Blogs',
blogs_path %>
```

#### As a user, I can click a button that will submit my blog post to the database.

```Ruby
def create
  @blog = Blog.create(blog_params)
end

private

def blog_params
  params.require(:blog).permit(:title, :content)
end
```

```Ruby
post '/blogs' => 'blog#create'
```

#### As a user, I when I submit my post, I am redirected to the home page.

```Ruby
def create
  @blog = Blog.create(blog_params)
  if @blog.valid?
    redirect_to blogs_path
  else
    redirect_to new_blog_path
  end
end
```

## Stretch Challenges

#### As a user, I can delete my blog post.

```Ruby
def destroy
  @blog = Blog.find(params[:id])
  @blog.destroy
  redirect_to new_blog_path
end
```

```Ruby
delete '/blogs/:id' => 'blog#destroy', :as => 'destroy_blog'
```

```Ruby
# added this to show.html.erb
<%= link_to 'Delete Post', destroy_blog_path, :method => :delete %>
```

#### As a user, I can update my blog post.

```Ruby
def edit
  @blog = Blog.find(params[:id])
end

def update
  @blog = Blog.find(params[:id])
  @blog.update(blog_params)
  if @blog.valid?
    redirect_to blogs_path(@blog)
  else
    redirect_to edit_blog_path(@blog)
  end
end
```

```Ruby
get '/blogs/:id/edit' => 'blog#edit', :as => 'edit_blog'
```

```Ruby
<h1>Edit Blog Post</h1>
<%= form_with model: @blog, method: :patch do |form| %> <%= form.label :title %>
<%= form.text_field :title %>

<br />
<%= form.label :content %> <%= form.text_field :content %>

<br />
<%= form.submit 'Update blog' %> <% end %> <%= link_to 'Return to All Blog',
blog_path %>
```

#### As a developer, I can ensure that all blog posts have titles and content for each post.

```Shell
$ bundle add rspec-rails
$ rails generate rspec:install
$ mkdir spec/models
$ touch spec/models/blog_spec.rb # made it manually since we didn't start with rpsec
```

```Ruby
require 'rails_helper'

RSpec.describe Blog, type: :model do
  it 'is valid with valid attributes' do
    post =
      Blog.create title: 'Post Title!',
                  content: 'This is the content of the blog'
    expect(post).to be_valid
  end
  it 'must have a title' do
    post = Blog.create content: 'This is the content of the blog'
    expect(post.errors[:title]).to_not be_empty
  end
  it 'must have content' do
    post = Blog.create title: 'Post Title!'
    expect(post.errors[:content]).to_not be_empty
  end
end
```

```Ruby
# models/blog.rb
class Blog < ApplicationRecord
  validates :title, :content, presence: true
end
```

#### As a developer, I can ensure that all blog post titles are unique.

```Ruby
it 'must have unique titles' do
  post1 =
    Blog.create title: 'Post Title!',
                content: 'This is the content of the blog'
  post2 =
    Blog.create title: 'Post Title!',
                content: 'This is the content of the other blog'
  expect(post2.errors[:title]).to_not be_empty
end
```

```Ruby
validates :title, uniqueness: true
```

#### As a developer, I can ensure that blog post titles are at least 10 characters.

```Ruby
it 'must have at least 10 characters in the title' do
  post = Blog.create title: 'Post', content: 'This is the content of the blog'
  expect(post.errors[:title]).to_not be_empty
end
```

```Ruby
validates :title, length: { minimum: 10 }
```
