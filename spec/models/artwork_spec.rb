require 'rails_helper'

RSpec.describe Artwork, type: :model do
  context 'Associations' do
    it { should belong_to(:artist) }
    it { should belong_to(:classification) }
    it { should belong_to(:department) }
  end

  context 'DB Triggers' do
    it 'should create search ts vector on create' do
      @artist = Artist.create(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000))
      @classification = Classification.create(title: Faker::Book.genre)
      @department = Department.create(title: Faker::Book.publisher)
      @artwork = Artwork.create!(artist: @artist, classification: @classification, department: @department, title: Faker::Book.title)
      @artwork.reload
      expect(@artwork.search).to be
    end
  end
end
