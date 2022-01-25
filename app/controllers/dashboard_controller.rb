class DashboardController < ApplicationController
  before_action :authenticate_admin!
  layout 'dashboard/dashboard'
  
  def index
    @admin = current_admin
  end
end
