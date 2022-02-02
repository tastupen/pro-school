class RoomsController < ApplicationController
  def show
    @room = Room.find(params[:id]) #ルーム情報の取得
    @message = Message.new #新規メッセージ投稿
    @messages = @room.messages #このルームのメッセージを全て取得
    if user_signed_in?
      if @room.user.id == current_user.id
        @admin = @room.admin
      else
        redirect_to "/"
      end
    elsif admin_signed_in?
      if @room.admin.id == current_admin.id
        @chat_user = @room.user
      else
        redirect_to "/"
      end
  
    else
      redirect_to "/"
    end
    @major_category_names = Category.major_categories
    @categories = Category.all
    @user = current_user
    @chat_admin = current_admin
  end

  def create
    if user_signed_in?
      #userがログインしてたらuser_idを, shopがログインしてたらshop_idを@roomにいれる
      @room = Room.new(room_admin_params)
      @room.user_id = current_user.id
    elsif admin_signed_in?
      @room = Room.new(room_user_params)
      @room.admin_id = current_admin.id
    else
      redirect_to "/"
    end

    if @room.save
      redirect_to :action => "show", :id => @room.id
    else
      redirect_to "/"
    end
  end

  private
  def room_admin_params
    params.require(:room).permit(:admin_id)
  end

  def room_user_params
    params.require(:room).permit(:user_id)
  end
end
