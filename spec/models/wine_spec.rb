require 'rails_helper'

RSpec.describe Wine, :type => :model do
  describe "model validations" do 
    subject { build(:wine) }
    before do 
        create(:price_history)
    end
    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end 

    it "is not valid without a name" do 
        subject.name = nil
        expect(subject).to_not be_valid
    end 

    it "is not valid without a variety" do 
        subject.variety = nil
        expect(subject).to_not be_valid
    end 

    it "is not valid without a region" do 
        subject.region = nil
        expect(subject).to_not be_valid
    end 

    it "is not valid without a non numeric year" do 
        subject.year = "2010y"
        expect(subject).to_not be_valid
    end 

    it "is not valid without a future year" do 
        subject.year = Date.today.year + 1
        expect(subject).to_not be_valid
    end 
  end 

  describe '#latest_price' do
    let(:wine) { create(:wine) }

    context 'when there are no prices' do
      it 'returns nil' do
        expect(wine.latest_price).to be_nil
      end
    end

    context 'when there are prices' do
      before do
        @old_price = create(:price_history, wine: wine, price: 100.0, recorded_at: 1.day.ago)
        @latest_price = create(:price_history, wine: wine, price: 150.0, recorded_at: Time.now)
      end

      it 'returns the latest price' do
        expect(wine.latest_price).to eq(@latest_price.price)
      end
    end
  end 
end