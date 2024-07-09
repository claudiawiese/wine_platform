class ReviewsController < ApplicationController
    before_action :authenticate_devise_api_token!
    def index
        devise_api_token = current_devise_api_token
        if devise_api_token
            @reviews = current_devise_api_user.reviews
            render json: @reviews
        else
            render json: {message: "You have to be log in to see reviews"}, status: :unauthorized
        end
    end
  
    # GET /reviews/:id
    def show
      review = current_devise_api_user.reviews.find(params[:id])
      render json: review
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Review not found' }, status: :not_found
    end
  
    # POST /reviews
    def create
      review = current_devise_api_user.reviews.build(review_params)

      if review.save
        render json: review, status: :created
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    # PATCH/PUT /reviews/:id
    def update
      review = current_devise_api_user.reviews.find(params[:id])

      if review.update(review_params)
        render json: review
      else
        render json: { errors: review.errors.full_messages }, status: :unprocessable_entity
      end
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Review not found' }, status: :not_found
    end
  
    # DELETE /reviews/:id
    def destroy
      review = current_devise_api_user.reviews.find(params[:id])
      review.destroy
      head :no_content
    rescue ActiveRecord::RecordNotFound
      render json: { error: 'Review not found' }, status: :not_found
    end
  
    private
  
    def review_params
      params.require(:review).permit(:wine_id, :rating, :comment)
    end
=begin
#under construction
    def verify_user_role
      if !current_devise_api_user.expert?
        render json: { error: 'User is not an expert' }
      end
    end
=end 
end