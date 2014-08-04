require 'rails_helper'

RSpec.describe "campaigns/show", :type => :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :hashtag => "Hashtag"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hashtag/)
  end
end
