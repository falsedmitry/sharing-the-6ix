class User < ApplicationRecord
  has_secure_password
  has_many :owned_tools, class_name: "Tool"
  has_many :reviews
  has_many :loans
  has_many :borrowed_tools, -> {distinct}, through: :loans, source: :tool

  has_secure_password

  def rating
    rating = 0.0
    number_of_reviews = 0

    owned_tools.each do |tool|
      tool.reviews.each do |review|
        rating += review.rating
        number_of_reviews += 1
      end
    end

    if number_of_reviews < 5
      0
    else
      rating / number_of_reviews
    end
  end
end
