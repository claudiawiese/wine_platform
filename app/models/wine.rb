class Wine < ApplicationRecord
    has_many :reviews, dependent: :destroy
    has_many :prices, dependent: :destroy

    validates :name, presence: true
    validates :variety, presence: true
    validates :region, presence: true
    validates :year, presence: true,
                    numericality: { only_integer: true, less_than_or_equal_to: Date.today.year }

     # Method to get the latest price history record
    def latest_price
        self.prices.order(recorded_at: :desc).first&.price
    end
end
