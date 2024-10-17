# README

## Description
This app is an API that allows the user to see different wines with different ratings and prices 

Logged in users can write reviews with a rating and a comment. The authentication process is using the devise gem. 

User can have different roles. But the application policies linked to the user roles are still in progress. The idea is to set it up with the pundit gem. 

An external wine api service can be plugged into the app by using the external_api_service. 

## Ruby and RoR Versions
* Ruby version: 3.2
* Rails version: Rails 7.1.3.4

## Project Installation
You need docker and docker-compose 

Step 1: docker-compose build 
Step 2: docker-compose up 
Step 3: docker-compose run web rails db:seed

Application should be available at localhost:3000 

## Wine Actions
### get /wines
curl --location --request GET 'http://127.0.0.1:3000/wines' 

### get /wines/min_price=[:price]&max_price[:price]
curl --location --request GET 'http://127.0.0.1:3000/wines/min_price=[:price]&max_price[:price]' 

### get /wine_price_histories
curl --location --request GET 'http://127.0.0.1:3000/wine_price_histories' 

## Sign up and sign in
### example sign up for new user 

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_up' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@example.com",
    "password": "123456"
    "role_id": 3
}'

### example sign in with user

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_in' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "expert@example.com",
    "password": "password"
}'

genrates token to look at user's reviews' list

## Review actions

### get /reviews
curl --location --request GET 'http://127.0.0.1:3000/reviews' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'

### get /reviews/:id
curl --location --request GET 'http://127.0.0.1:3000/reviews/:id' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'

### post /reviews/
curl --location --request PATCH 'http://127.0.0.1:3000/reviews/:id' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'
--data-raw '{
    "rating": "5",
    "comment": "my comment"
    "wine_id": "wine_id"
}'

### patch /reviews/:id
curl --location --request PATCH 'http://127.0.0.1:3000/reviews/:id' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'
--data-raw '{
    "rating": "4",
    "comment": "new comment"
}'

### delete /reviews/:id
curl --location --request DELETE 'http://127.0.0.1:3000/reviews/:id' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'

## Functional Tests
All functional tests can be found in the spec folder 
You can launch the test with the following command:

docker-compose run web rspec 
