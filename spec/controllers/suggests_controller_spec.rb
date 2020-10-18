require 'rails_helper'

RSpec.describe SuggestsController, type: :controller do

  let(:valid_session) { {} }

  describe "Artists suggesting" do
    before(:each) do
      build_artists = create_list(:artist, 25)
    end

    it "return at least one Artist record by first 3 chars of name" do
      q = Artist.last.display_name[0..2]
      get :artists, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end

    it "return at least one Artist record by first 3 chars of nationality" do
      q = Artist.last.nationality[0..2]
      get :artists, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end

    it "return at empty record by not matching symbols" do
      q = '23@'
      get :artists, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
    end
  end

  describe "Arts suggesting" do
    before(:each) do
      build_artists = create_list(:artwork, 25)
    end

    it "return at least one Artist record by first 3 chars of name" do
      q = Artwork.last.title[0..2]
      get :artworks, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end

    it "return at least one Artist record by first 3 chars of nationality" do
      q = Artwork.last.accession_number[0..2]
      get :artworks, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end

    it "return at empty record by not matching symbols" do
      q = '23@'
      get :artworks, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
    end
  end

  describe "Classifications suggesting" do
    before(:each) do
      build_classifications= create_list(:classification, 25)
    end

    it "return at least one Classification record by first 3 chars of name" do
      q = Classification.last.title[0..2]
      get :classifications, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end


    it "return at empty record by not matching symbols" do
      q = '23@'
      get :classifications, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
    end
  end

  describe "Departments suggesting" do
    before(:each) do
      build_departments= create_list(:department, 25)
    end

    it "return at least one Department record by first 3 chars of name" do
      q = Department.last.title[0..2]
      get :departments, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).not_to be_empty
    end

    it "return at empty record by not matching symbols" do
      q = '23@'
      get :departments, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
    end
  end

  describe "All Models suggesting" do
    before(:each) do
      FactoryBot.create(:department, title: 'Films')
      FactoryBot.create(:classification, title: 'Films about animals')
      FactoryBot.create(:artist, display_name: 'Filip')
      FactoryBot.create(:artwork, title: 'Filip dancing')
    end

    it "return at least one  record of each type by first 3 chars of name" do
      q ='Fil'
      get :all_models, params: { q: q }, session: valid_session
      expect(response).to be_successful
      json = JSON.parse(response.body, symbolize_names: true)
      expect(json).not_to be_empty
      types =  json.map{|h| h[:searchable_type]}
      expect(types).to include('Artwork')
      expect(types).to include('Artist')
      expect(types).to include('Classification')
      expect(types).to include('Department')
    end

    it "return at empty record by not matching symbols" do
      q = '23@'
      get :all_models, params: { q: q }, session: valid_session
      expect(response).to be_successful
      expect(JSON.parse(response.body, symbolize_names: true)).to be_empty
    end
  end
  
end