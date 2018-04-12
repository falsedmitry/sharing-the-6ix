class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tool
  has_one :rating, dependent: :destroy

  mount_uploaders :images, ImageUploader

  validates :comment, presence: true
end
