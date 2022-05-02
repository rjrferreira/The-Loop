# ticket-loop

Prototype of an online ticket store (using rails cache)

## Run with Docker

Rename the **.env.dist** to **.env**.
If you want to use the default configuration please change your hosts file to create a custom DNS entry, to solve **redis** to **127.0.0.1**

```
127.0.0.1 redis
```

The file **entrypoints/docker-entrypoint.sh** must have permissions to be executed:

```
chmod +x entrypoints/docker-entrypoint.sh
```

Finally to run with docker container run the following command:

```
docker-compose up -d
```

If you run
```
docker ps
```
Yous should be able to see three running contianers: ticket-loop-railscache_app_1, ticket-loop-railscache_redis_1 and ticket-loop-railscache_database_1

The application url is: http://localhost:3000

## Run Locally without Docker

### Check your Ruby and Rails version

```
ruby -v
```

This project was developed over 2.4.1p111 ruby version.
For more information please visit https://www.ruby-lang.org/en/news/2017/03/22/ruby-2-4-1-released/

```
rails -v
```

This project was developed over 5.1.7 rails version.

### Install dependencies

Please open a command line in the root folder (where the Gemfile file is located), and run the following command:

```
bundle install
```

### Initialize the database

Please open a command line in the root folder, and run the following command:

```
rails db:create db:migrate db:seed
```

### Run project

You need to have a local Redis server running in port 6379.

Now you are ready to start your application. In the root folder run the following command:

```
puma
```

## Test on browser

For test this application please open the browser and write "http://127.0.0.1:3000/".
If you want to see the all mechanism working, open more than two browser windows (for example: a normal window and a incognito window, or simple use another browser).


## Authors

* **Rodrigo Ferreira**
