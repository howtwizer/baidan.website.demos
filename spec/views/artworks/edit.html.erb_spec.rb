require 'rails_helper'

RSpec.describe "artworks/edit", type: :view do
  before(:each) do
    @classification = Classification.create(title: Faker::Book.genre)
    @department = Department.create(title: Faker::Book.publisher)
    @artist = Artist.create(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000))
    @artwork = assign(:artwork, Artwork.create!(title: Faker::Book.title, classification: @classification, department: @department, artist: @artist))
  end

  it "renders the edit artwork form" do
    render

    assert_select "form[action=?][method=?]", artwork_path(@artwork), "post" do
    end
  end
end
