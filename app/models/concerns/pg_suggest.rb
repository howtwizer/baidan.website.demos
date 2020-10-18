module
PgSuggest
  extend ActiveSupport::Concern
  include PgSearch::Model

  included do
    pg_search_scope :pg_suggest_dmetaphone,
                    against: :search,
                    using:   {
                      dmetaphone: {
                        tsvector_column: 'search',
                        any_word:        true
                      },
                      tsearch:    {
                        tsvector_column: 'search',
                        prefix:          true,
                        any_word:        true
                      }
                    }

    pg_search_scope :pg_suggest,
                    against:   :search,
                    using:     {
                      tsearch: {
                        tsvector_column: 'search',
                        prefix:          true,
                        any_word:        true
                      }
                    }
  end
end
