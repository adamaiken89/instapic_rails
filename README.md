# Instagrapic Backend

**System Specification**

* Language: Ruby 3.0.2
* Framework: Rails 6.1.4.1
* Database: Postgres 13

**System Setup and Configuration**

For the first time usage, please run the database migration. 

1. Install ruby (For Mac)
```
$ brew install rbenv
$ rbenv install 3.0.2
```
Or follow the instructions here for other platforms
https://www.ruby-lang.org/en/documentation/installation/

2. Install dependency
```
bundle install
```

3. Make sure you have already started the database server. Create the database and run migration files
```
rails db:create
rails db:migrate
```

**Start the server**
```
rails server
```
You can go to 

**Key files in the System**

```
app/controllers/*
app/models/*
app/views/route/*
test/*
```

**Integration Testing**
Without coverage test
```
rails test
```

With coverage test
```
COVERGE=1 rails test
```

**Baseurl** 
https://instapicrails.herokuapp.com/
