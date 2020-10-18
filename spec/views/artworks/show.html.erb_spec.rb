require 'rails_helper'

RSpec.describe "artworks/show", type: :view do
  before(:each) do
    @classification = Classification.create(title: Faker::Book.genre)
    @department = Department.create(title: Faker::Book.publisher)
    @artist = Artist.create(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000))
    @artwork = assign(:artwork, Artwork.create!(title: Faker::Book.title, classification: @classification, department: @department, artist: @artist))
  end

  it "renders attributes in <p>" do
    render
  end
end
