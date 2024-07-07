class Wine < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :prices, dependent: :destroy

     # Method to get the latest price history record
    def latest_price
        self.prices.order(created_at: :desc).first&.price
    end
end
