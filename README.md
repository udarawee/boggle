# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* System dependencies
     * Ruby (see .ruby-version) or use rvm/rbenv
     * Node (see .nvmrc) or use nvm
     * [Yarn](https://yarnpkg.com/)
     * [Redis](https://redis.io/topics/quickstart)
        * For storing dictionary

* Database creation(postgres)
    * `bundle exec rake db:create`
   
* How to run the test suite
     * `bundle exec rspec`

* Configuration
     * Run `bundle exec rake redis:setup[simple]` to seed redis with a small dictionary
     * Run `bundle exec rake redis:setup` to seed redis with a more exhaustive dictionary. This will take considerably longer
          
* Running locally
    * After cloning, run the following   
     ```
      $ bundle install
      $ yarn
      $ bundle exec rails s
     ```
    * In another tab run `$ redis-server`
    * If you want the webpack dev server for live reload run `$ ./bin/webpack-dev-server` in another tab