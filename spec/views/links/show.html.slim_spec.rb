require 'rails_helper'

RSpec.describe "links/show", :type => :view do
  before(:each) do
    @link = assign(:link, Link.create!(
      :anchor => "Anchor",
      :href => "Href",
      :title => "MyText",
      :city_id => 1,
      :destination_id => 2,
      :state_id => 3
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Anchor/)
    expect(rendered).to match(/Href/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
  end
end
