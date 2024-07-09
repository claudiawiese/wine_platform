class WinesController < ApplicationController
    def index      
      @wines = Wine.all.includes(:reviews, :prices).left_joins(:reviews)
      .select('wines.*, AVG(reviews.rating) AS average_rating')
      .group('wines.id')
      .order('average_rating DESC NULLS LAST')      

      filter_by_price
        
      wines_with_average_ratings = @wines.map do |wine|
          {
            id: wine.id,
            name: wine.name,
            variety: wine.variety,
            region: wine.region,
            year: wine.year,
            average_rating: wine.reviews.present? ? wine.reviews.average(:rating).to_f.round(2) : "n.a.",
            price: wine.latest_price,
          }
      end
    
      render json: wines_with_average_ratings
    end

    def fetch_wines_via_external_api
      format = params[:format] == 'xml' ? :xml : :json
      ExternalApiService.new.fetch_wine_data(format)
    end 

    def wine_price_histories
      @wines = Wine.all.includes(:prices)
      wines_with_price_history = @wines.map do |wine|
        {
          id: wine.id,
          name: wine.name,
          prices: wine.prices.order(recorded_at: :desc).map do |price|
            { price: price.price,
             recorded_at: price.recorded_at
            }
          end 
        }
      end 
      render json: wines_with_price_history 
    end 

    private

    def filter_by_price
        if params[:min_price].present? && params[:max_price].present?
            min_price = params[:min_price].to_f
            max_price = params[:max_price].to_f
            @wines = @wines.select do |wine|
                latest_price = wine.latest_price
                latest_price.present? && latest_price >= min_price && latest_price <= max_price
            end
        end
    end 
  end
  