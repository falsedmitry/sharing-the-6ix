class User < ApplicationRecord
  has_many :owned_tools, class_name: "Tool"
  has_many :reviews
  has_many :loans
  has_many :borrowed_tools, through: :loans, source: :tool
  belongs_to :neighbourhood
  has_many :chats
  has_many :owned_chats, through: :owned_tools, source: :chats

  has_secure_password
  mount_uploader :avatar, AvatarUploader

  validates :name, :email, :postal_code, presence: true
  validates :password, length: { minimum: 8 }
  validates :email, uniqueness: true

  def tools_out_on_loan
    out_on_loan = []

    owned_tools.each do |tool|
      if tool.on_loan == true
        out_on_loan << tool
      end
    end

    out_on_loan
  end

  def currently_borrowed_tools
    currently_borrowed_tools = []

    borrowed_tools.each do |tool|
      if tool.active_loan && tool.active_loan.borrower == self
        currently_borrowed_tools << tool
      end
    end

    currently_borrowed_tools
  end
end
