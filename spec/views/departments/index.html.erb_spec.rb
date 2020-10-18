require 'rails_helper'

RSpec.describe "departments/index", type: :view do
  before(:each) do
    assign(:departments, [
      Department.create!(title: Faker::Book.publisher),
      Department.create!(title: Faker::Book.publisher)
    ])
  end

  it "renders a list of departments" do
    render
  end
end
