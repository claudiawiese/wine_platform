class ReviewsController < ApplicationController
    before_action :authenticate_devise_api_token!
    def index
        devise_api_token = current_devise_api_token
        if devise_api_token
            user = current_devise_api_user
            @reviews = Review.where(user_id: user.id)
            render json: @reviews
        else
            render json: {message: "You have to be log in to see reviews"}, status: :unauthorized
        end
    end
  end
  