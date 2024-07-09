require 'rails_helper'

RSpec.describe Price, :type => :model do
  describe "model validations" do 
    subject { build(:price_history) }
  
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end 

    it "is not valid without a wine" do 
        subject.wine_id = nil
        expect(subject).to_not be_valid
    end 

    it "is not valid without negative price" do 
        subject.price = -1
        expect(subject).to_not be_valid
    end 
  end 
end