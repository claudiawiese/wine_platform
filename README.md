# README

* Ruby version: 3.2
* DB: postgreSQL

## Project Installation
You need docker and docker-compose 

Step 1: docker-compose build 
Step 2: docker-compose up 
Step 3: docker-compose run web rails db:seed

Application should be available at localhost:3000 

## Wine index
curl --location --request GET 'http://127.0.0.1:3000/wines' 

## Sign up and sign in
### example sign up for new user 

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_up' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@example.com",
    "password": "123456"
    "role_id": 3
}'

### example sign in with expert user

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_in' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "expert@example.com",
    "password": "password"
}'

genrates token to look at expert user's reviews' list

## Review actions

##see signed up user's reviews 

curl --location --request GET 'http://127.0.0.1:3000/reviews' \                               
--header 'Authorization: Bearer <user_token>' \
--header 'Content-Type: application/json'
