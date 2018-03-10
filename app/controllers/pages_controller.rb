class PagesController < ApplicationController

  def index
  	I18n.locale = :uk
  	@notification=Notification.where(user_id: current_user.id)
  	@categories = Category.all
  end

end
