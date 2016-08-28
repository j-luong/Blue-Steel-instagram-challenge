class Picture < ApplicationRecord
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"

  validates :caption, length: { minimum: 3 }, uniqueness: true
  validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
end
