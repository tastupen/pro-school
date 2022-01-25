class AdminsController < ApplicationController
  before_action :authenticate_admin!
  before_action :set_admin
  layout 'dashboard/dashboard'

  def edit_profile
  end

  def update
    @admin.update_without_password(admin_params)
    redirect_to dashboard_path
  end

  def edit_account
  end

  private
    def set_admin
      @admin = current_admin
    end

    def admin_params
      params.require(:admin).permit(:name, :description, :email, :password, :password_confirmation, :image)
    end
end
