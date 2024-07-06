class WinesController < ApplicationController
    def index
        @wines = Wine.all.includes(:reviews) # Ensure reviews are eager loaded to avoid N+1 queries

        wines_with_average_ratings = @wines.map do |wine|
          {
            id: wine.id,
            name: wine.name,
            variety: wine.variety,
            region: wine.region,
            year: wine.year,
            average_rating: wine.reviews.present? ? wine.reviews.average(:rating).to_f.round(2) : "n.a."
          }
        end
    
        render json: wines_with_average_ratings
    end
  end
  