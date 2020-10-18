class Classification < ApplicationRecord
  include Multisearch
  include PgSuggest

  validates :title, presence: true

  has_many :artworks

end
