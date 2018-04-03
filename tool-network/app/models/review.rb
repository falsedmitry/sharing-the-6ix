class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tool
  has_many :images
end
