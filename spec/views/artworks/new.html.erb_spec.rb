require 'rails_helper'

RSpec.describe "artworks/new", type: :view do
  before(:each) do
    assign(:artwork, Artwork.new())
  end

  it "renders new artwork form" do
    render

    assert_select "form[action=?][method=?]", artworks_path, "post" do
    end
  end
end
