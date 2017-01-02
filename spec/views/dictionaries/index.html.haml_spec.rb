require 'rails_helper'

RSpec.describe "dictionaries/index", type: :view do
  before(:each) do
    assign(:dictionaries, [
      Dictionary.create!(
        :user_id => 2,
        :title => "Title",
        :resource_type => ""
      ),
      Dictionary.create!(
        :user_id => 2,
        :title => "Title",
        :resource_type => ""
      )
    ])
  end

  it "renders a list of dictionaries" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
