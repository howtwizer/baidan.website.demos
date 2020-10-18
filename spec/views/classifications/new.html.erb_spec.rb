require 'rails_helper'

RSpec.describe "classifications/new", type: :view do
  before(:each) do
    assign(:classification, Classification.new())
  end

  it "renders new classification form" do
    render

    assert_select "form[action=?][method=?]", classifications_path, "post" do
    end
  end
end
