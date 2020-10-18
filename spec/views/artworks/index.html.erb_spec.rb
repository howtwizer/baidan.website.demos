require 'rails_helper'

RSpec.describe "artworks/index", type: :view do
  before(:each) do
    @classification = Classification.create(title: 'Test Classification')
    @department = Department.create(title: 'Test Departments')
    @artist = Artist.create(display_name: 'Test Artist', constituent_id:  Random.new.rand(10000))
    assign(:artworks, [
      Artwork.create!(title: Faker::Book.title, classification: @classification, department: @department, artist: @artist),
      Artwork.create!(title: Faker::Book.title, classification: @classification, department: @department, artist: @artist)
    ])
  end

  it "renders a list of artworks" do
    render
  end
end
