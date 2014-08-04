require 'rails_helper'

RSpec.describe "searches/edit", :type => :view do
  before(:each) do
    @search = assign(:search, Search.create!(
      :hashtag => "MyString"
    ))
  end

  it "renders the edit search form" do
    render

    assert_select "form[action=?][method=?]", search_path(@search), "post" do

      assert_select "input#search_hashtag[name=?]", "search[hashtag]"
    end
  end
end
