require 'rails_helper'

RSpec.describe "Chattops", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/chattop/index"
      expect(response).to have_http_status(:success)
    end
  end

end
