require 'rails_helper'

RSpec.describe Classification, type: :model do
  context 'Associations' do
    it { should have_many(:artworks) }
  end

  context 'DB Triggers' do
    it 'should create search ts vector on create' do
      @classification = Classification.create(title: Faker::Book.genre)
      @classification.reload
      expect(@classification.search).to be
    end
  end
end
