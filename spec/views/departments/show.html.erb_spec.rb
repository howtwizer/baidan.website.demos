require 'rails_helper'

RSpec.describe "departments/show", type: :view do
  before(:each) do
    @department = assign(:department, Department.create!(title: Faker::Book.publisher))
  end

  it "renders attributes in <p>" do
    render
  end
end
