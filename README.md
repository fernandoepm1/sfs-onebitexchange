# OneBitExchange

Convert monetary values from around the world, now with cryptocurrencies.

## Running the app

To run the app locally you need to have [Docker](https://docs.docker.com/install/) installed, and follow these steps:

1. Clone the project using
```git
git clone git@github.com:fernandoepm1/sfs-onebitexchange.git
```

2. Run docker-compose.yml file with
```
docker-compose up --build
```

3. Create the database with
```
docker run --rm app bundle exec rake db:create
```

4. Acess the app in http://localhost:3000
