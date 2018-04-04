class User < ApplicationRecord
  has_secure_password
  has_many :owned_tools, class_name: "Tool"
  has_many :reviews
  has_many :loans
  has_many :borrowed_tools, -> {distinct}, through: :loans, source: :tool

  has_secure_password

  def tools_out_on_loan
    out_on_loan = []

    owned_tools.each do |tool|
      if tool.on_loan == true
        out_on_loan << tool
      end
    end

    out_on_loan
  end

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
