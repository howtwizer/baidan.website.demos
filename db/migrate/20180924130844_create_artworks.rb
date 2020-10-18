class CreateArtworks < ActiveRecord::Migration[5.2]
  def change
    create_table :artworks do |t|
      t.references :constituent, index: true
      t.belongs_to :classification, index: true, foreign_key: true
      t.belongs_to :department, index: true, foreign_key: true
      t.string :title, index: true
      t.string :date
      t.string :medium
      t.string :dimensions
      t.string :credit_line
      t.string :accession_number
      t.string :date_acquired
      t.boolean :cataloged
      t.string :url
      t.string :thumbnail_url
      t.float :circumference #cm
      t.float :depth #cm
      t.float :diameter #cm
      t.float :height #cm
      t.float :length #cm
      t.float :weight #kg
      t.float :width #cm
      t.float :seat_height #cm
      t.integer :duration #sec
      t.tsvector :search, index: {using: 'gin'} # Generalized Inverted Index
      t.timestamps
    end
    add_foreign_key  :artworks, :artists, column: :constituent_id, primary_key: :constituent_id, on_delete: :cascade
  end
end
