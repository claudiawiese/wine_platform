require 'rails_helper'
RSpec.describe "Wines", type: :request do
    describe "GET /wines" do
      before do
        create (:user)

        create(:wine, name: "Chateau Margaux", variety: "Red Bordeaux Blend", region: "Margaux, Bordeaux, France", year: 2015)
        create(:wine, name: "Penfolds Grange",variety: "Shiraz",region: "Barossa Valley, South Australia", year: 2010)
        create(:wine, name: "Opus One", variety: "Red Bordeaux Blend", region: "Napa Valley, California, USA", year: 2014 )

        create(:price_history, wine: Wine.first, price: 10.0, recorded_at: Time.now - 1.year)
        create(:price_history, wine: Wine.first , price: 11.0, recorded_at: Time.now - 6.months)
        create(:price_history, wine: Wine.find_by(variety: "Shiraz"), price: 20.0, recorded_at: Time.now - 1.year)
        create(:price_history, wine: Wine.find_by(variety: "Shiraz"), price: 22.0, recorded_at: Time.now - 6.months)
        create(:price_history, wine: Wine.find_by(variety: "Shiraz"), price: 22.32, recorded_at: Time.now - 2.months)
        create(:price_history, wine: Wine.last, price: 7.25, recorded_at: Time.now - 6.months)
        create(:price_history, wine: Wine.last, price: 8.33, recorded_at: Time.now - 2.months)

        create(:review, wine: Wine.find_by(variety: "Shiraz"), user: User.first, rating: 5)
        create(:review, wine: Wine.find_by(variety: "Shiraz"), user: User.first, rating: 5)
        create(:review, wine: Wine.last, user: User.first, rating: 4)
        create(:review, wine: Wine.last, user: User.first, rating: 3)
        create(:review, wine: Wine.last, user: User.first, rating: 2)
      end
  
      it "returns a list of wines" do
        get '/wines'
        expect(response).to have_http_status(:success)
        
        json = JSON.parse(response.body)
        expect(json.size).to eq(3)
      end

      it "returns wines with their latest price" do
        get '/wines'
        expect(response).to have_http_status(:success)

        json = JSON.parse(response.body)
        expect(json[0]['price']).to eq('22.32')
        expect(json[1]['price']).to eq('8.33')
        expect(json[2]['price']).to eq('11.0')
      end
  
      it "filters wines by price range" do
        get '/wines', params: { min_price: 20, max_price: 23 }
        expect(response).to have_http_status(:success)
  
        json = JSON.parse(response.body)
        expect(json.size).to eq(1)
        expect(json.first['name']).to eq('Penfolds Grange')
      end

      it "shows no wine if no wine exists in price range" do
        get '/wines', params: { min_price: 1, max_price: 2 }
        expect(response).to have_http_status(:success)
  
        json = JSON.parse(response.body)
        expect(json.size).to eq(0)
      end

      it "returns wines with highest rating first" do
        get '/wines'
        expect(response).to have_http_status(:success)
  
        json = JSON.parse(response.body)
        expect(json.first['average_rating']).to eq(5.0)
      end

      it "returns wines with no rating last and displays n.a." do
        get '/wines'
        expect(response).to have_http_status(:success)
  
        json = JSON.parse(response.body)
        expect(json.last['average_rating']).to eq("n.a.")
      end
    end
  end