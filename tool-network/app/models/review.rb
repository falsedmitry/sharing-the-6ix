class Review < ApplicationRecord
  belongs_to :user
  belongs_to :tool
  has_many :images

  validates :rating, :comment, presence: true
  validates :rating, numericality: { only_integer: true, greater_than: 0, less_than: 6 }


  def has_pictures
    unless self.images.any?
      self.errors[:review] << "must have images"
    end
  end



end
