class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tool
  has_many :images

  validates :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }
  
end
