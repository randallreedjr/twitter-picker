require 'rails_helper'

RSpec.describe "searches/new", :type => :view do
  before(:each) do
    assign(:search, Search.new(
      :hashtag => "MyString"
    ))
  end

  it "renders new search form" do
    render

    assert_select "form[action=?][method=?]", searches_path, "post" do

      assert_select "input#search_hashtag[name=?]", "search[hashtag]"
    end
  end
end
