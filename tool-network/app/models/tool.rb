class Tool < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: 'user_id'
  has_many :borrowers, through: :reviews, source: :user
  has_many :reviews

  has_many :loans
  has_many :owner_images

  def lend_out
    self.on_loan = true
    self.save
  end

  def get_back
    self.on_loan = false
    self.save
  end

end
