class CreateDepartments < ActiveRecord::Migration[5.2]
  def change
    create_table :departments do |t|
      t.string :title, index: true
      t.tsvector :search, index: {using: 'gin'}
      t.timestamps
    end
  end
end
