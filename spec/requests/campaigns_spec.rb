require 'rails_helper'

RSpec.describe "Campaigns", :type => :request do
  describe "GET /campaigns" do
    it "works! (now write some real specs)" do
      get campaigns_path
      expect(response.status).to be(200)
    end
  end
end
