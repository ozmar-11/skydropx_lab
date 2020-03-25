## A

This is the A application, intend to be the main application, the one that fetch the messages from kafka and save the
status of the packages into its DB

### Be sure you have
- Run Redis (if you haven't) `redis-server`
- Run kafka server (if you havent)
- Run postgresql

This is common Rails 6 app so in order to get it up an running locally you need to:
- install dependencies running `bundle` or `bundle install`
- Run sidekiq `sidekiq -C config/sidekiq.yml`

### TODO
- Add a packages page to see the status of all the packages, because currently we have to check them from the rails
console or directly from the DB.
