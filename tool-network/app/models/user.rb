class User < ApplicationRecord
  has_secure_password
  has_many :owned_tools, class_name: "Tool"
  has_many :reviews
  has_many :borrowed_tools, -> {distinct}, through: :reviews, source: :tool
end
