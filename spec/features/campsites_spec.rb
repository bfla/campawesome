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
  subject { page }
  let(:campsite) { FactoryGirl.create(:campsite) }

  describe "when user is not signed in" do
    before { visit campsite_path(campsite.id) }
    puts campsite.name
    it { should have_content(campsite.name) }
  end

end

#describe "resetSearch"
#end
#describe "show page" do
  #subject { page }
  #let(:campsite) { FactoryGirl.create(:campsite) }
  #before { visit campsite_path(campsite) }

  #describe "when user is not signed in" do
    #it { should have_content(campsite.name) }
  #end

  #describe "when user is signed in" do
    #before do
      #simulate_sign_in
      #visit campsite_path(campsite)
    #end
    #it { should have_content(campsite.name) }
  #end

#end