class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :picture
  
  validates :message, presence: true, length: { minimum: 2 }
end
