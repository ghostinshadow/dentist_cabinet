require 'rails_helper'

RSpec.describe "dictionaries/new", type: :view do
  before(:each) do
    assign(:dictionary, Dictionary.new(
      :user_id => 1,
      :title => "MyString",
      :resource_type => ""
    ))
  end

  it "renders new dictionary form" do
    render

    assert_select "form[action=?][method=?]", dictionaries_path, "post" do

      assert_select "input#dictionary_user_id[name=?]", "dictionary[user_id]"

      assert_select "input#dictionary_title[name=?]", "dictionary[title]"

      assert_select "input#dictionary_resource_type[name=?]", "dictionary[resource_type]"
    end
  end
end
