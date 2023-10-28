class User < ApplicationRecord
  self.primary_key = 'user_id'
  has_many :posts
  has_one :role
end
