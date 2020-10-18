class AddTriggersToTables < ActiveRecord::Migration[5.2]
  def up
    # with weight
    create_trigger('artists_search_tsvector_update', compatibility: 1).on(:artists).before(:insert, :update) do
      "new.search := setweight(to_tsvector('pg_catalog.simple', coalesce(new.display_name,'')), 'A') ||
                     setweight(to_tsvector('pg_catalog.simple', coalesce(new.nationality,'')), 'B')"
    end


    # without weight
    create_trigger('artworks_search_tsvector_update', compatibility: 1).on(:artworks).before(:insert, :update) do
      "new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,'')) ||
                     to_tsvector('pg_catalog.simple', coalesce(new.accession_number,''))"
    end

    create_trigger('departments_search_tsvector_update', compatibility: 1).on(:departments).before(:insert, :update) do
      "new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,''))"
    end

    create_trigger('classifications_search_tsvector_update', compatibility: 1).on(:classifications).before(:insert, :update) do
      "new.search := to_tsvector('pg_catalog.simple', coalesce(new.title,''))"
    end

  end

  def down
    drop_trigger('artists_search_tsvector_update', :artists)
    drop_trigger('artworks_search_tsvector_update', :artworks)
    drop_trigger('departments_search_tsvector_update', :departments)
    drop_trigger('classifications_search_tsvector_update', :classifications)
  end
end
