require 'rails_helper'
require 'webmock/rspec'

RSpec.describe ExternalApiService do
  describe '#fetch_wine_data' do
    let(:service) { ExternalApiService.new }

    context 'when the response is JSON' do
      before do
        stub_request(:get, "https://api.example.com/wines")
          .to_return(body: '[{"name":"Wine A","variety": null, "region":null,"year":null,"prices":[{"amount":null}]}]', headers: { 'Content-Type' => 'application/json' })
      end

      it 'creates wines with default values for missing attributes' do
        expect { service.fetch_wine_data(:json) }.to change { Wine.count }.by(1)
          .and change { Price.count }.by(1)

        wine = Wine.first
        expect(wine.name).to eq('Wine A')
        expect(wine.variety).to eq('Unknown Variety')
        expect(wine.region).to eq('Unknown Region')
        expect(wine.year).to eq(0)
        expect(wine.prices.first.price).to eq(0.0)
      end
    end

    context 'when the response is XML' do
      before do
        stub_request(:get, "https://api.example.com/wines")
          .to_return(body: '<wines><wine><name>Wine A</name><variety/><region/><year/><prices><price><amount/></price></prices></wine></wines>', headers: { 'Content-Type' => 'application/xml' })
      end

      it 'creates wines with default values for missing attributes' do
        expect { service.fetch_wine_data(:xml) }.to change { Wine.count }.by(1)
          .and change { Price.count }.by(1)

        wine = Wine.first
        expect(wine.name).to eq('Wine A')
        expect(wine.variety).to eq('Unknown Variety')
        expect(wine.region).to eq('Unknown Region')
        expect(wine.year).to eq(0)
        expect(wine.prices.first.price).to eq(0.0)
      end
    end
  end
end