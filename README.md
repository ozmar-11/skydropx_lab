# SkydropX Lab

This is my personal solution to the SkydropX Lab which contains the main and
microservice apps each of them has their own README file for their installing
instructions

Deploying the apps into heroku or anyother service should not be a problem, but
running them locally means the following steps to be shared accross both apps.

- Run redis using `redis-server` we just need a single redis service running so
you can run it into the root folder and will be available for both apps

Run the following commands to get kafka server up and running in your local
run these commands into the kafka folder
- run the kafka server as this is an MVP we can use the default kafka config
running the zookeper included into kafka using 
`bin/zookeeper-server-start.sh config/zookeeper.properties`
- run the kafka server using 
`bin/kafka-server-start.sh config/server.properties`
