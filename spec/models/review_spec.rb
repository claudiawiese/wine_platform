require 'rails_helper'

RSpec.describe Review, :type => :model do
  describe "model validations" do 
    subject { build(:review) }
  
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end 

    it "is not valid without a rating" do 
        subject.rating = nil
        expect(subject).to_not be_valid
    end 

    it "is not valid with a rating above 5" do 
      subject.rating = 6
      expect(subject).to_not be_valid
    end

    it "is not valid with a rating below 0" do 
      subject.rating = -1
      expect(subject).to_not be_valid
    end

    it "is not valid without wine" do 
      subject.wine_id = 0
      expect(subject).to_not be_valid
    end

    it "is not valid without user" do 
      subject.user_id = 0
      expect(subject).to_not be_valid
    end
  end 
end