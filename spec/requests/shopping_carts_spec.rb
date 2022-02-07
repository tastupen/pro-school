require 'rails_helper'

RSpec.describe "ShoppingCarts", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/shopping_carts/index"
      expect(response).to have_http_status(:success)
    end
  end

end
