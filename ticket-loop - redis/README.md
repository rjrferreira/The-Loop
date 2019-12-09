# ticket-loop

Prototype of an online ticket store (using redis database)

## Check your Ruby and Rails version

```
ruby -v
```

This project was developed over 2.4.1 ruby version.
For more information please visit https://www.ruby-lang.org/en/news/2017/03/22/ruby-2-4-1-released/

```
rails -v
```

This project was developed over 5.1.7 rails version.

## Install dependencies

Please open a command line in the root folder (where the Gemfile file is located), and run the following command:

```
bundle install
```

### Run project

Then you need to have a local Redis server running in port 6379.

Now you are ready to start your application. In the root folder run the following command:

```
rails s
```

For test this application please open the browser and write "http://127.0.0.1:3000/". 
If you want to see the all mechanism working, open more than two browser windows (for example: new tabs).


## Authors

* **Rodrigo Ferreira** 

## License

This project is licensed under the MIT License - see the [LICENSE.md](LICENSE.md) file for details
