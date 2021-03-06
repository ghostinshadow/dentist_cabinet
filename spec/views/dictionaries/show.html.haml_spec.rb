require 'rails_helper'

RSpec.describe "dictionaries/show", type: :view do
  before(:each) do
    @dictionary = assign(:dictionary, Dictionary.create!(
      :user_id => 2,
      :title => "Title",
      :resource_type => ""
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(//)
  end
end
