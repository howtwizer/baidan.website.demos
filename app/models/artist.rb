class Artist < ApplicationRecord
  include Multisearch
  include PgSuggest

  validates :display_name, presence: true
  validates :constituent_id, presence: true, uniqueness: true

  has_many :artworks, foreign_key: :constituent_id, primary_key: :constituent_id

  # For PgSearchDocs
  alias_attribute :title, :display_name
end
