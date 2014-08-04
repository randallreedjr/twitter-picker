require 'rails_helper'

RSpec.describe "campaigns/index", :type => :view do
  before(:each) do
    assign(:campaigns, [
      Campaign.create!(
        :hashtag => "Hashtag"
      ),
      Campaign.create!(
        :hashtag => "Hashtag"
      )
    ])
  end

  it "renders a list of campaigns" do
    render
    assert_select "tr>td", :text => "Hashtag".to_s, :count => 2
  end
end
