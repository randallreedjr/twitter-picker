require 'rails_helper'

RSpec.describe "campaigns/new", :type => :view do
  before(:each) do
    assign(:campaign, Campaign.new(
      :hashtag => "MyString"
    ))
  end

  it "renders new campaign form" do
    render

    assert_select "form[action=?][method=?]", campaigns_path, "post" do

      assert_select "input#campaign_hashtag[name=?]", "campaign[hashtag]"
    end
  end
end
