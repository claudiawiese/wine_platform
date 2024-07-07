# Clear existing records to avoid duplication during development
Review.destroy_all
Wine.destroy_all
User.destroy_all
Price.destroy_all


# Seed data for users
user = User.create!(
  email: 'user@example.com',
  password: 'password',
  password_confirmation: 'password'
)

puts "Seed data for users created successfully!"

# Seed data for wines
wines = [
  { name: "Chateau Margaux", variety: "Red Bordeaux Blend", region: "Margaux, Bordeaux, France", year: 2015 },
  { name: "Penfolds Grange", variety: "Shiraz", region: "Barossa Valley, South Australia", year: 2010 },
  { name: "Opus One", variety: "Red Bordeaux Blend", region: "Napa Valley, California, USA", year: 2014 }
]

# Create wines from the seed data
created_wines = wines.map do |wine_params|
  Wine.create!(wine_params)
end

puts "Seed data for wines created successfully!"

#Seed data for review
reviews = [
  { rating: 4, comment: "Great taste and aroma.", wine_id: Wine.first.id, user_id: user.id},
  { rating: 5, comment: "Absolutely delicious! Would buy again.", wine_id: Wine.first.id, user_id: user.id},
  { rating: 3, comment: "Decent wine for the price.", wine_id: Wine.first.id, user_id: user.id},
  # Add more reviews as needed
]

# Create reviews from the seed data
reviews.each do |review_params|
  Review.create!(review_params)
end

# Seed data for prices
prices = [
  { wine: created_wines[0], price: 7.0, created_at: Time.now - 2.year },
  { wine: created_wines[0], price: 10.0, created_at: Time.now - 6.months },
  { wine: created_wines[1], price: 15.0, created_at: Time.now - 1.year },
  { wine: created_wines[1], price: 16.0, created_at: Time.now - 6.months },
  { wine: created_wines[2], price: 18.0, created_at: Time.now - 1.year },
  { wine: created_wines[2], price: 20.0, created_at: Time.now - 6.months }
]

# Create prices from the seed data
prices.each do |price|
  Price.create!(price)
end

puts "Seed data for prices created successfully!"