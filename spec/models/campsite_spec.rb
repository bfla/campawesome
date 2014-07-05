require 'rails_helper'

#RSpec.describe Campsites, :type => :model do
  #pending "add some examples to (or delete) #{__FILE__}"
#end

describe Campsite do
  before do 
    @campsite = Campsite.new(
      name:         "Unicorn",
      description:  "Yatta yatta",
      org:          "Federal",
      res_phone:     1234567890,
      camp_phone:    1234567890,
      res_url:      "http://example.com",
      camp_url:     "http://example.com",
      reservable:   true,
      walkin:       true,
      latitude:     44.9131,
      longitude:    -83.9131,
      address:      "1234 Fakeness St, Lilliput, MI 48152",
      state_id:     1,
      city_id:      1,
      avg_rating:   4.5,
      city_rank:    1,
      slug:         "sup-mutha",
      rv_length:    50 )
  end
  subject { @campsite }

  # attributes
  it { should respond_to(:name) }
  it { should respond_to(:description) }
  it { expect respond_to(:org) }
  it { expect respond_to(:res_phont) }
  it { expect respond_to(:camp_phone) }
  it { expect respond_to(:res_url) }
  it { expect respond_to(:camp_url) }
  it { expect respond_to(:reservable) }
  it { expect respond_to(:walkin) }
  it { expect respond_to(:latitude) }
  it { expect respond_to(:longitude) }
  it { expect respond_to(:address) }
  it { expect respond_to(:state_id) }
  it { expect respond_to(:city_id) }
  it { expect respond_to(:avg_rating) }
  it { expect respond_to(:city_rank) }
  it { expect respond_to(:slug) }
  it { expect respond_to(:rv_length) }


  # methods
  it { expect respond_to(:state_name) }
  it { expect respond_to(:hashtag) }
  it { expect respond_to(:tribes_json) }
  it { expect respond_to(:primary_icon) }
  it { expect respond_to(:has_tribe) }
  it { expect respond_to(:icons) }
  it { expect respond_to(:geojsonify) }
  it { expect respond_to(:import) }
  it { expect respond_to(:search) }
  it { expect respond_to(:name_search) }
  it { expect respond_to(:to_s) }
  it { expect respond_to(:slug_me_up) }
  it { expect respond_to(:seed_blanks) }

  # check validity
  it { expect be_valid }

  describe "when name is not present" do
    before {@campsite.name = ""}
    it { should_not @campsite.save }
  end

  describe "when org is not present" do
    before { @campsite.org = "" }
    it { should_not be_valid }
  end

  describe "when latitude is not present" do
    before { @campsite.latitude = nil }
    it { should_not be_valid }
  end

  describe "when latitude is in the Southern hemisphere" do
    before { @campsite.latitude = -44.56789 }
    it { should_not be_valid }
  end

  describe "when longitude is in the Eastern hemisphere" do
    before { @campsite.longitude = 88.91234 }
    it { should_not be_valid }
  end

  # Should probably add tests for...
  # (1) ensure phone numbers are in a valid format
  # (2) place restrictions on name length
  # (2) methods... make sure they behave nicely

end