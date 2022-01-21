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
  it 'must have unique titles' do
    post1 =
      Blog.create title: 'Post Title!',
                  content: 'This is the content of the blog'
    post2 =
      Blog.create title: 'Post Title!',
                  content: 'This is the content of the other blog'
    expect(post2.errors[:title]).to_not be_empty
  end
  it 'must have at least 10 characters in the title' do
    post = Blog.create title: 'Post', content: 'This is the content of the blog'
    expect(post.errors[:title]).to_not be_empty
  end
end
