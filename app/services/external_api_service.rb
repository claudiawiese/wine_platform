class ExternalApiService
    include HTTParty
    base_uri 'https://api.example.com' 
    headers  'Accept' => 'application/json, application/xml'

    DEFAULT_VARIETY = "Unknown Variety"
    DEFAULT_REGION = "Unknown Region"
    DEFAULT_YEAR = 0
    DEFAULT_PRICE = 0.0

    def fetch_wine_data(format = :json)
      response = self.class.get('/wines')
      return unless response.success?
  
      format == :json ? process_json_wine_data(response.parsed_response) : process_xml_wine_data(response.body)
    end
  
    private
  
    def process_json_wine_data(data)
      data.each do |wine_data|
        wine = Wine.find_or_create_by(name: wine_data['name']) do |w|
          w.variety = wine_data['variety'] || DEFAULT_VARIETY
          w.region = wine_data['region'] || DEFAULT_REGION
          w.year = wine_data['year'] || DEFAULT_YEAR
        end
      
        wine_data['prices'].each do |price_data|
          wine.prices.create(price: price_data['amount'] || DEFAULT_PRICE)
        end
      end
    end

    def process_xml_wine_data(xml_data)
        data = Nokogiri::XML(xml_data)
    
        data.xpath('//wine').each do |wine_node|
          wine = Wine.find_or_create_by(name: wine_node.xpath('name').text) do |w|
            w.variety = wine_node.xpath('variety').text.present? ? wine_node.xpath('variety').text : DEFAULT_VARIETY
            w.region = wine_node.xpath('region').text.present? ? wine_node.xpath('region').text : DEFAULT_REGION
            w.year = wine_node.xpath('year').text.to_i || DEFAULT_YEAR
          end
          
          wine_node.xpath('prices/price').each do |price_node|
            wine.prices.create(price: price_node.xpath('amount').text.to_f || DEFAULT_PRICE)
          end
        end
    end 
  end
  