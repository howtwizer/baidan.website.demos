class SuggestsController < ApplicationController

  def artists
    @artists =  Artist.pg_suggest(suggester_params[:q]).first(5)
    render json: @artists
  end

  def artworks
    @artworks =  Artwork.pg_suggest(suggester_params[:q]).first(5)
    render json: @artworks
  end

  def classifications
    @classifications =  Classification.pg_suggest(suggester_params[:q]).first(5)
    render json: @classifications
  end

  def departments
    @departments =  Department.pg_suggest(suggester_params[:q]).first(5)
    render json: @departments
  end

  def all_models
    @results =  PgSearchDocument.preload(:searchable).rank_filter(suggester_params[:q])
    render json: @results
  end


  private

  def suggester_params
    params.permit(:q, :scope)
  end
end