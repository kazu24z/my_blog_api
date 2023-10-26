class Post < ApplicationRecord
  enum status: { draft: 0, open: 1 }

  belongs_to :user
end
