# Note
# every Artwork has search tsvector field that contains "title" and accession_number
class Artwork < ApplicationRecord
  include Filterable
  include Multisearch
  include PgSuggest

  validates :title, presence: true

  belongs_to :artist, foreign_key: :constituent_id, primary_key: :constituent_id
  belongs_to :classification, optional: true
  belongs_to :department, optional: true

  # Filters
  #
  scope :suggest, ->(sq) {

  }
  scope :artwork, ->(ids_string) { where(id: ids_string.to_array) if ids_string.present? }
  scope :artist, ->(ids_string) { where(constituent_id: Artist.where(id: ids_string.to_array).pluck(:constituent_id)) if ids_string.present? }
  scope :classification, ->(ids_string) { where(classification_id: ids_string.to_array) if ids_string.present? }
  scope :department, ->(ids_string) { where(department_id: ids_string.to_array) if ids_string.present? }
end
