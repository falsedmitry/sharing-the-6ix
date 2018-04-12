class Loan < ApplicationRecord
  belongs_to :borrower, class_name: "User", foreign_key: 'user_id'
  belongs_to :tool

  validates :start_date, :due_date, presence: true

  validate :start_date_cannot_be_in_the_past
  validate :due_date_is_after_start_date
  validate :lender_cannot_be_borrower

  def start_date_cannot_be_in_the_past
    if start_date && start_date < Date.today
      errors[:loan_date] << 'cannot be in the past'
    end
  end

  def due_date_is_after_start_date
    if due_date && start_date && due_date < start_date
      errors[:due_date] << 'cannot be before loan date'
    end
  end

  def overdue?
    due_date < Date.today
  end

  def lender_cannot_be_borrower
    if borrower == tool.owner
      errors[:this] << 'tool is yours'
    end
  end

end
