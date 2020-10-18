require 'rails_helper'

RSpec.describe Department, type: :model do

  context 'Associations' do
    it { should have_many(:artworks) }
  end

  context 'DB Triggers' do
    it 'should create search ts vector on create' do
      @department = Department.create(title: Faker::Book.publisher)
      @department.reload
      expect(@department.search).to be
    end
  end
end
