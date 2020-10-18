class CreateArtists < ActiveRecord::Migration[5.2]
  def change
    create_table :artists do |t|
      t.string :display_name
      t.text :artist_bio
      t.string :nationality
      t.string :gender
      t.integer :begin_date
      t.integer :end_date
      t.string :wiki
      t.string :ulan
      t.integer :constituent_id, index: {unique: true}
      t.tsvector :search, index: {using: 'gin'} # Generalized Inverted Index
      t.timestamps
    end
  end
end
