class ArtworkReflex < ApplicationReflex
  def search
    session[:query] = element[:value]&.strip
    session[:suggests] = PgSearchDocument.preload(:searchable).rank_filter(session[:query])
    session[:suggest_value] = element.dataset["suggest-value"]
    session[:searchable_id] = element.dataset["searchable-id"]
    session[:searchable_type] = element.dataset["searchable-type"]
  end

  def order
    session[:order_by] = element.dataset["column-name"]
    session[:direction] = element.dataset["direction"]
  end

  def paginate
    session[:page] = element.dataset[:page].to_i
  end
end
