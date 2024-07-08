# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

### example sign up for new user 

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_up' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@development.com",
    "password": "123456"
}'

### example sign in with test user

curl --location --request POST 'http://127.0.0.1:3000/users/tokens/sign_in' \                                                     
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "test@development.com",
    "password": "123456"
}'

genrates token to look at user's reviews' list

### check user's review

curl --location --request GET 'http://127.0.0.1:3000/reviews' \                                                                   
--header 'Authorization: Bearer s7Q_FNezuj6NQaBf7eYj-4fDM8Lz3JB9XUcJQRgiutX45K8UVu3iY9fUNFy_' \
--header 'Content-Type: application/json'



