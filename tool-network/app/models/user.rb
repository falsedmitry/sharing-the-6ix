class User < ApplicationRecord
  has_many :owned_tools, class_name: "Tool"
  has_many :reviews
  has_many :borrowed_tools, -> {distinct}, through: :reviews, source: :tool

  has_secure_password
end
