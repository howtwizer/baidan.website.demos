require 'rails_helper'

RSpec.describe "artists/index", type: :view do
  before(:each) do
    assign(:artists, [
      Artist.create!(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000)),
      Artist.create!(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000))
    ])
  end

  it "renders a list of artists" do
    render
  end
end
