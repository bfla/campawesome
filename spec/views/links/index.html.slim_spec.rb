require 'rails_helper'

RSpec.describe "links/index", :type => :view do
  before(:each) do
    assign(:links, [
      Link.create!(
        :anchor => "Anchor",
        :href => "Href",
        :title => "MyText",
        :city_id => 1,
        :destination_id => 2,
        :state_id => 3
      ),
      Link.create!(
        :anchor => "Anchor",
        :href => "Href",
        :title => "MyText",
        :city_id => 1,
        :destination_id => 2,
        :state_id => 3
      )
    ])
  end

  it "renders a list of links" do
    render
    assert_select "tr>td", :text => "Anchor".to_s, :count => 2
    assert_select "tr>td", :text => "Href".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => 3.to_s, :count => 2
  end
end
