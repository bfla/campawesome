require 'rails_helper'

#RSpec.describe "Campsites", :type => :request do
  #describe "GET /campsites" do
    #it "works! (now write some real specs)" do
      #get campsites_index_path
      #expect(response.status).to be(200)
    #end
  #end
#end

describe "public-facing campsite pages" do

  subject { page }

  describe "show page" do
    let(:campsite) { FactoryGirl.create(:campsite) }
    #before visit {@campsite}

  end

  describe "search" do

  end

end

#describe "resetSearch"
#end