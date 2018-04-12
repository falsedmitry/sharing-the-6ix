class Neighbourhood < ApplicationRecord
  has_many :users

  mount_uploader :nbhd_image, NbhdImageUploader

  def tools
    tools = []

    users.each do |user|
      user.owned_tools.each do |tool|
        tools << tool
      end
    end

    tools
  end
end
