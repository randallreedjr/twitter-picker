require 'rails_helper'

RSpec.describe "searches/show", :type => :view do
  before(:each) do
    @search = assign(:search, Search.create!(
      :hashtag => "Hashtag"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Hashtag/)
  end
end
