class Wine < ApplicationRecord
    has_many :reviews, dependent: :destroy
end
