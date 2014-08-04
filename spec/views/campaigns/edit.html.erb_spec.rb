require 'rails_helper'

RSpec.describe "campaigns/edit", :type => :view do
  before(:each) do
    @campaign = assign(:campaign, Campaign.create!(
      :hashtag => "MyString"
    ))
  end

  it "renders the edit campaign form" do
    render

    assert_select "form[action=?][method=?]", campaign_path(@campaign), "post" do

      assert_select "input#campaign_hashtag[name=?]", "campaign[hashtag]"
    end
  end
end
