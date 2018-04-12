class PagesController < ApplicationController

  def about
  end

  def contact
    users = ["drosenfeld87@gmail.com", "dmitry.sbn@gmail.com", "li_bill@ymail.com"]
    @users = users.sample(3)
  end

  def privacy
  end

end
