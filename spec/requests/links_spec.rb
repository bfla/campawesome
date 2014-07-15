require 'rails_helper'

RSpec.describe "Links", :type => :request do
  describe "GET /links" do
    it "works! (now write some real specs)" do
      get links_path
      expect(response.status).to be(200)
    end
  end
end
