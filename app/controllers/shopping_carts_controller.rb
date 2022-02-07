class ShoppingCartsController < ApplicationController
  before_action :set_cart, only: %i[index create destroy cart_destroy lesson_destroy]
  def index
    @user_cart_items = ShoppingCartItem.user_cart_items(@user_cart)
    @user = current_user
  end

  def show
    @cart = ShoppingCart.find(user_id: current_user)
  end

  def create
    @lesson = Lesson.find(lesson_params[:lesson_id])
    @user_cart.add(@lesson, lesson_params[:price].to_i, lesson_params[:quantity].to_i)
    redirect_to cart_users_path
  end

  def update
  end

  def destroy
    @user_cart.buy_flag = true
    @user_cart.save

    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create( 
                          :customer => current_user.token,
                          :amount => @user_cart.total.to_i,
                          :currency => 'jpy'
                        )

    redirect_to after_perchase_users_path
  end

  def after_perchase
    @user = current_user
  end

  def cart_destroy
    @user_cart.clear
    redirect_to cart_users_path
  end

  def lesson_destroy
    @lesson = Lesson.find(lesson_params[:lesson_id])
    @user_cart.remove(@lesson, lesson_params[:quantity].to_i)
    redirect_to cart_users_path
  end

  private
    def lesson_params
      params.permit(:lesson_id, :price, :quantity)
    end

    def set_cart
      @user_cart = ShoppingCart.set_user_cart(current_user)
    end
end
