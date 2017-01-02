require 'rails_helper'

RSpec.describe "words/edit", type: :view do
  before(:each) do
    @word = assign(:word, Word.create!(
      :user_id => 1,
      :title => "MyString",
      :resource_type => ""
    ))
  end

  it "renders the edit word form" do
    render

    assert_select "form[action=?][method=?]", word_path(@word), "post" do

      assert_select "input#word_user_id[name=?]", "word[user_id]"

      assert_select "input#word_title[name=?]", "word[title]"

      assert_select "input#word_resource_type[name=?]", "word[resource_type]"
    end
  end
end
