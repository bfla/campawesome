require 'rails_helper'

RSpec.describe "links/edit", :type => :view do
  before(:each) do
    @link = assign(:link, Link.create!(
      :anchor => "MyString",
      :href => "MyString",
      :title => "MyText",
      :city_id => 1,
      :destination_id => 1,
      :state_id => 1
    ))
  end

  it "renders the edit link form" do
    render

    assert_select "form[action=?][method=?]", link_path(@link), "post" do

      assert_select "input#link_anchor[name=?]", "link[anchor]"

      assert_select "input#link_href[name=?]", "link[href]"

      assert_select "textarea#link_title[name=?]", "link[title]"

      assert_select "input#link_city_id[name=?]", "link[city_id]"

      assert_select "input#link_destination_id[name=?]", "link[destination_id]"

      assert_select "input#link_state_id[name=?]", "link[state_id]"
    end
  end
end
