class CreateShoppingCartItems < ActiveRecord::Migration[6.1]
  def change
    create_table :shopping_cart_items do |t|
      t.shopping_cart_item_fields
      
      t.timestamps
    end
  end
end
