module Multisearch
  extend ActiveSupport::Concern

  included do
    has_one :pg_search_document, as: :searchable, dependent: :delete
    after_save :create_or_update_pg_search_document
    after_touch :create_or_update_pg_search_document
  end

  protected

  def create_or_update_pg_search_document
    reload

    if !pg_search_document
      create_pg_search_document(search: search, title: title)
    else
      pg_search_document.update(search: search, title: title)
    end
  end
end