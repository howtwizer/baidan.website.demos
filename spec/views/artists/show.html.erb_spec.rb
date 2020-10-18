require 'rails_helper'

RSpec.describe "artists/show", type: :view do
  before(:each) do
    @artist = assign(:artist, Artist.create!(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000)))
  end

  it "renders attributes in <p>" do
    render
  end
end
