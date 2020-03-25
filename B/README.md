## B

This is the B application, intend to be a microservice that fetch the packages from different carriers to send them to
kafka.

### Be sure you have
- Run Redis (if you haven't) `redis-server`
- Run kafka server (if you havent)

This is common Rails 6 app so in order to get it up an running locally you need to:
- install dependencies running `bundle` or `bundle install`
- Run sidekiq `sidekiq -C config/sidekiq.yml`
