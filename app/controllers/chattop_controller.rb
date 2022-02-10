class ChattopController < ApplicationController
  def index
    if user_signed_in?
      @keyward = params[:keyward]

      if @keyward.present?
        @admins = Admin.search(@keyward)
      else
        @admins = Admin.all
      end

      rooms = current_user.rooms
      #自分が入ってるroomの相手のidを格納する
      @admin_ids = []
      rooms.each do |r|
        @admin_ids << r.admin_id
      end
    elsif admin_signed_in?
      @keyward = params[:keyward]

      if @keyward.present?
        @users = User.search(@keyward)
      else
        @users = User.all
      end
      rooms = current_admin.rooms
      #自分が入ってるroomの相手のidを格納する
      @user_ids = []
      rooms.each do |r|
        @user_ids << r.user_id
      end
    end
    @major_category_names = Category.major_categories
    @categories = Category.all
    @user = current_user
  end
end
