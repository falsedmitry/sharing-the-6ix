class Loan < ApplicationRecord
  belongs_to :borrower, class_name: "User", foreign_key: 'user_id'
  belongs_to :tool

end
