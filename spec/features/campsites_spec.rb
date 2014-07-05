require 'rails_helper'

#RSpec.describe "Campsites", :type => :request do
  #describe "GET /campsites" do
    #it "works! (now write some real specs)" do
      #get campsites_index_path
      #expect(response.status).to be(200)
    #end
  #end
#end
describe "campsite pages" do
  describe "show page" do
    subject { page }
    puts "trying to create campsite..."
    let(:campsite) { FactoryGirl.create(:campsite) }
    puts "campsite created..."
    before { visit campsite_path(campsite) }

    describe "when user is not signed in" do
      it { should have_content(campsite.name) }
    end

    describe "when user is signed in" do
      before do
        simulate_sign_in
        visit campsite_path(campsite)
      end
      it { should have_content(campsite.name) }
    end

  end
end

#describe "resetSearch"
#end