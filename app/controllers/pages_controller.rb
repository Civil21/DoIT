class PagesController < ApplicationController

  def index
  	@notification=Notification.where(user_id: current_user.id)
  	@categories = Category.all
  end

end
