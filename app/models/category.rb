class Category < ApplicationRecord
    has_and_belongs_to_many :tools, :join_table => :categorizations
end
