class SearchController < ApplicationController
  def index
    @query ||= nil
    @loading ||= false
    @suggest_matches ||= []
    @artworks ||= []
  end
end
