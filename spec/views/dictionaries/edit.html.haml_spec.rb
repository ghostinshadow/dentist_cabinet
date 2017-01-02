require 'rails_helper'

RSpec.describe "dictionaries/edit", type: :view do
  before(:each) do
    @dictionary = assign(:dictionary, Dictionary.create!(
      :user_id => 1,
      :title => "MyString",
      :resource_type => ""
    ))
  end

  it "renders the edit dictionary form" do
    render

    assert_select "form[action=?][method=?]", dictionary_path(@dictionary), "post" do

      assert_select "input#dictionary_user_id[name=?]", "dictionary[user_id]"

      assert_select "input#dictionary_title[name=?]", "dictionary[title]"

      assert_select "input#dictionary_resource_type[name=?]", "dictionary[resource_type]"
    end
  end
end
