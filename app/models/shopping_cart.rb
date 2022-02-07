class ShoppingCart < ApplicationRecord
  acts_as_shopping_cart

  scope :set_user_cart, -> (user) { user_cart = where(user_id: user.id, buy_flag: false)&.last
                               user_cart.nil? ? ShoppingCart.create(user_id: user.id)
                                              : user_cart }

  scope :bought_carts, -> { where(buy_flag: true) }

  scope :search_carts_by_user, -> (user) { where(user_id: user) }
  scope :search_bought_carts_by_user, -> (user) { bought_carts.search_carts_by_user(user) }

  def tax_pct
    0
  end
end
