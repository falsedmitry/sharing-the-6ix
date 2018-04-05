class Image < ApplicationRecord
  belongs_to :tool
  belongs_to :review

  validates :description, :url, presence: true
end
