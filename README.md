## Installation

Install the dependencies and start the server.

```sh
cd reward_system
bundle install
bundle exec rackup
```

## To Run Tests

```sh
rspec specs/
```
## How To Test


```sh
curl --location --request POST 'http://localhost:9292/calculate_rewards' \
--header 'Authorization: Basic OnBhc3N3b3Jk' \
--form 'file=@"/reward_system/sample.txt"'
```
NB: Make sure you have sample.txt in the right path
##### or
* Create a post request using postman http://localhost:9292/calculate_rewards
* Select form-data from body and add key as file, attach sample.txt file from the root path
* Use basic auth from autherization and add password as `password`