class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tool
  has_many :images

  validates :comment, presence: true
  validates :rating, presence: true
end
