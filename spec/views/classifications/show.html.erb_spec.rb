require 'rails_helper'

RSpec.describe "classifications/show", type: :view do
  before(:each) do
    @classification = assign(:classification, Classification.create!(title: Faker::Book.genre))
  end

  it "renders attributes in <p>" do
    render
  end
end
