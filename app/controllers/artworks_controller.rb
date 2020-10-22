class ArtworksController < ApplicationController

  def index
    @query = session[:query]
    @suggests = session[:suggests] || []
    @searchable_id = session[:searchable_id]
    @searchable_type = session[:searchable_type]
    @order_by = permitted_column_name(session[:order_by])
    @direction = permitted_direction(session[:direction])

    artworks = Artwork.order(@order_by => @direction)
    if @searchable_id.present? && @searchable_type.present? && %w[Artwork Artist Classification Department].include?(@searchable_type)
      @query = "[#{@searchable_type}] #{session[:suggest_value]}"
      artworks = artworks.send(@searchable_type.downcase, @searchable_id)
    else
      artworks = @query.present? ? artworks.pg_suggest(@query) : artworks.all
    end
    page_count = (artworks.count / Pagy::VARS[:items].to_f).ceil
    page_count = 1 if page_count.zero?

    @page = (session[:page] || 1).to_i
    @page = page_count if @page > page_count
    @pagy, @artworks = pagy(artworks, page: @page)
  end

  def show
    @artwork = Artwork.find(params[:id])
  end

  private

  def permitted_column_name(column_name)
    %w[accession_number title date].find { |permitted| column_name == permitted } || "title"
  end

  def permitted_direction(direction)
    %w[asc desc].find { |permitted| direction == permitted } || "asc"
  end
end
