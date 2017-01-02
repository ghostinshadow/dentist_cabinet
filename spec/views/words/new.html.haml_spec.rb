require 'rails_helper'

RSpec.describe "words/new", type: :view do
  before(:each) do
    assign(:word, Word.new(
      :user_id => 1,
      :title => "MyString",
      :resource_type => ""
    ))
  end

  it "renders new word form" do
    render

    assert_select "form[action=?][method=?]", words_path, "post" do

      assert_select "input#word_user_id[name=?]", "word[user_id]"

      assert_select "input#word_title[name=?]", "word[title]"

      assert_select "input#word_resource_type[name=?]", "word[resource_type]"
    end
  end
end
