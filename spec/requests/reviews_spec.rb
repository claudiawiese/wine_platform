require 'rails_helper'
RSpec.describe "Reviews", type: :request do
  describe "GET /reviews" do
    let(:user) { create(:user) }
    let(:user2) { create(:user) }
    let(:devise_api_token) { create(:devise_api_token, resource_owner: user) }
    let!(:wine) { create(:wine) }
    let!(:review1) { create(:review, wine: wine, user: user, rating: 5) }
    let!(:review2) { create(:review, wine: wine, user: user, rating: 5) }
    let!(:other_review) { create(:review, wine: wine, user: user2, rating: 2) }

    context 'when user is not logged in' do
      it "returns authorization error" do
        get '/reviews'
        expect(response).to have_http_status(401) 
      end
    end

    context 'when user is logged in' do
      before do 
        sign_in user
      end

      it "returns list of reviews of the current_user" do
        get '/reviews', headers: { 'Authorization' => "Bearer #{devise_api_token.access_token }"}
        expect(response).to have_http_status(200)  # Expecting 200 for authorized access
        json = JSON.parse(response.body)
        expect(json.size).to eq(2)
      end
    end
  end

  describe "GET /reviews/:id" do
    let(:user) { create(:user) }
    let(:devise_api_token) { create(:devise_api_token, resource_owner: user) }
    let(:wine) {create(:wine)}
    let!(:review1) { create(:review, wine: wine, user: user, rating: 5) }
    let!(:other_review) { create(:review, wine: wine, user: create(:user), rating: 2) }

    it 'returns a review of the signed-in user' do
      get "/reviews/#{review1.id}", headers: { 'Authorization' => "Bearer #{devise_api_token.access_token}" }
      expect(response).to have_http_status(200)  # Expecting 200 for authorized access
      json = JSON.parse(response.body)
      expect(json['id']).to eq(review1.id)
    end 

    it 'returns not found for reviews of other users' do
      get "/reviews/#{other_review.id}", headers: { 'Authorization' => "Bearer #{devise_api_token.access_token}" }
      expect(response).to have_http_status(404)  # Expecting 404 resource not found for this user
    end 
  end 

  describe "POST /reviews" do
    let(:user) { create(:user) }
    let(:devise_api_token) { create(:devise_api_token, resource_owner: user) }
    let(:wine) {create(:wine)}
    
    it 'creates a new review' do
      post '/reviews', params: { review: {wine_id: wine.id, rating: 4 } }, headers: { 'Authorization' => "Bearer #{devise_api_token.access_token}" }
      expect(response).to have_http_status(201)  # Adjust as per your application's response status
    end
  end
end
