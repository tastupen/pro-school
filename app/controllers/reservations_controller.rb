class ReservationsController < ApplicationController
  before_action :set_reservation, only: [:show, :edit, :update, :destroy]
  def index
    if user_signed_in?
      @reservations = current_user.reservations.all.order("start_time desc")
    elsif admin_signed_in?
      @reservations = current_admin.reservations.all.order("start_time desc")
    end
  end

  def show
  end

  def new
    @reservation = current_admin.reservations.new
    @lessons = current_admin.lessons.all
    @students = User.all
  end

  def create
    @reservation = current_admin.reservations.new(reservation_params)
    if @reservation.save
      redirect_to reservations_path, flash: { success: "レッスン予約が完了しました。"}
    else
      redirect_to new_reservation_path, flash: { danger: "レッスン予約に失敗しました。"}
    end
  end

  def edit
    @lessons = current_admin.lessons.all
    @students = User.all
  end

  def update
    if @reservation.update(reservation_update)
      redirect_to reservations_path, flash: { success: "レッスンの更新に成功しました。"} 
   else
      redirect_to edit_reservation_path, flash: { danger: "レッスンの更新に失敗しました。"}
   end
  end

  def destroy
    @reservation.destroy
    redirect_to reservations_path, flash: { success: "レッスンをキャンセルに成功しました。" }
  end

  private

    def reservation_params
      params.permit(:start_time, :user_id, :lesson_id, :admin_id)
    end 

    def reservation_update
      params.require(:reservation).permit(:start_time, :user_id, :lesson_id, :admin_id)
    end

    def set_reservation
      @reservation = Reservation.find(params[:id])
    end
end
