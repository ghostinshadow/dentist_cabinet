require 'rails_helper'

RSpec.describe "words/index", type: :view do
  before(:each) do
    assign(:words, [
      Word.create!(
        :user_id => 2,
        :title => "Title",
        :resource_type => ""
      ),
      Word.create!(
        :user_id => 2,
        :title => "Title",
        :resource_type => ""
      )
    ])
  end

  it "renders a list of words" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "".to_s, :count => 2
  end
end
