require 'rails_helper'

RSpec.describe "classifications/index", type: :view do
  before(:each) do
    assign(:classifications, [
      Classification.create!(title: Faker::Book.genre),
      Classification.create!(title: Faker::Book.genre)
    ])
  end

  it "renders a list of classifications" do
    render
  end
end
