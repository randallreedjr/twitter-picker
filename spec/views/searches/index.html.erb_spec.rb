require 'rails_helper'

RSpec.describe "searches/index", :type => :view do
  before(:each) do
    assign(:searches, [
      Search.create!(
        :hashtag => "Hashtag"
      ),
      Search.create!(
        :hashtag => "Hashtag"
      )
    ])
  end

  it "renders a list of searches" do
    render
    assert_select "tr>td", :text => "Hashtag".to_s, :count => 2
  end
end
