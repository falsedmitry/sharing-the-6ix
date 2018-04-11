class Chat < ApplicationRecord
  belongs_to :user
  belongs_to :tool

end
