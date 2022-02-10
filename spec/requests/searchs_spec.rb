require 'rails_helper'

RSpec.describe "Searchs", type: :request do
  describe "GET /seach" do
    it "returns http success" do
      get "/searchs/seach"
      expect(response).to have_http_status(:success)
    end
  end

end
