require 'rails_helper'

RSpec.describe Artist, type: :model do

  context 'Associations' do
    it { should have_many(:artworks) }
  end

  context 'DB Triggers' do
    it 'should create search ts vector on create' do
      @artist = Artist.create!(display_name: Faker::Artist.name, constituent_id:  Random.new.rand(10000))
      @artist.reload
      expect(@artist.search).to be
    end
  end
end
