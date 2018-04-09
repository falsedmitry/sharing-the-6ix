class Image < ApplicationRecord
  belongs_to :tool
  # belongs_to :review

  validates :url, presence: true
end
