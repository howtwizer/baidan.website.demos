class CreatePgSearchDocuments < ActiveRecord::Migration[5.2]
  def change
    create_table :pg_search_documents do |t|
      t.string :title
      t.tsvector :search, index: { using: 'gin' }
      t.belongs_to :searchable, polymorphic: true, index: true
      t.timestamps
    end
  end
end
