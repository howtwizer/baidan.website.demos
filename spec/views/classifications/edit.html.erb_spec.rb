require 'rails_helper'

RSpec.describe "classifications/edit", type: :view do
  before(:each) do
    @classification = assign(:classification, Classification.create!(title: Faker::Name.name))
  end

  it "renders the edit classification form" do
    render

    assert_select "form[action=?][method=?]", classification_path(@classification), "post" do
    end
  end
end
