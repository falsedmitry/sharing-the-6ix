class Tool < ApplicationRecord
  belongs_to :owner, class_name: "User", foreign_key: 'user_id'
  has_many :reviews
  has_many :loans
  has_many :borrowers, through: :loans, source: :borrower

  has_many :owner_images

  validates :name, :condition, :description, :loan_length, presence: true
  validates :condition, numericality: { only_integer: true, greater_than: 0, less_than: 11 }


  def lend_out
    self.on_loan = true
    self.save
  end

  def get_back
    self.on_loan = false
    self.save
  end

  def active_loan
    Loan.find_by(user_id: self.current_borrower.id, tool_id: self.id, active: true)
  end

  def current_borrower
    Loan.find_by(tool_id: self.id, active: true).borrower
  end

end
