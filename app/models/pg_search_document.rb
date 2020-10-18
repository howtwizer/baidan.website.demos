
# For Multi Model search - creating table that will handle all search records with polymorphic association to parent models
class PgSearchDocument < ApplicationRecord
  belongs_to :searchable, polymorphic: true

  scope :simple_search, ->(q) { where("(pg_search_documents.search) @@ (to_tsquery('simple', ''' ' || ? || ' ''' || ':*'))", q) }


  # This is query for complex suggesting for multi model search
  # It will return top N records of each searchable type in request
  # Example:
  # query: 'Ara'
  # return:
  # |--------------
  # | Artworks:
  # | Arabes Artwork 1
  # | Arabes Artwork 2
  # | Arabes Artwork 3
  # |--------------
  # | Autors:
  # | Aramil Author
  # | Arator Author
  # | Aragorn Author
  #
  # @param [String] query - request query
  # @param [Hash] options
  # @option options [:limit] - integer count of records returning in each group
  def self.rank_filter(query, options={})
    limit = options.fetch(:limit, 5)
    request = find_by_sql <<-SQL.strip_heredoc
        SELECT rank_filter.* FROM (
                          SELECT pg_search_documents.*,
                                 rank() OVER (
                                   PARTITION BY searchable_type
                                   ORDER BY created_at DESC
                                   )
                          FROM pg_search_documents
                          WHERE ((search) @@ (to_tsquery('simple', ''' ' || '#{query}' || ' ''' || ':*')))
                          ) rank_filter WHERE RANK <= #{limit}
    SQL
    ActiveRecord::Associations::Preloader.new.preload(request, :searchable)
    request
  end

  def self.grouped_rank_filter(query, options={})
    result = rank_filter(query, options={})
    puts result
  end
end
