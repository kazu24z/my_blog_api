class Post < ApplicationRecord
  self.primary_key = 'post_id'
  enum status: { draft: 0, open: 1 }

  belongs_to :user

  validates :title, length: { minimum: 0, maximum: 100 }
end
