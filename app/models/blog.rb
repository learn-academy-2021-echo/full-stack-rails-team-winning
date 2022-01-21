class Blog < ApplicationRecord
  validates :title, :content, presence: true
  validates :title, uniqueness: true
  validates :title, length: { minimum: 5 }
end
