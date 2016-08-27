class Comment < ApplicationRecord
  validates :message, presence: true, length: { minimum: 2 }
end
