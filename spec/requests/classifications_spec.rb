require 'rails_helper'

RSpec.describe "Classifications", type: :request do
  describe "GET /classifications" do
    it "works! (now write some real specs)" do
      get classifications_path
      expect(response).to have_http_status(200)
    end
  end
end
