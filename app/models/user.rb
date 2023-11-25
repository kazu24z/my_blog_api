class User < ApplicationRecord
  before_create :assign_jti

  self.primary_key = 'user_id'
  has_secure_password
  has_many :posts
  has_one :role

  private

  def assign_jti
    self.jti = SecureRandom.uuid
  end
end
