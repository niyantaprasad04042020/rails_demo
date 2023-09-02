# Active Record 

* ORM - ORM means object relational mapper which is used in ruby on rails that maps the rich set of objects to the tables in the database.
  i) One class for each table in the database
  ii) Objects of the class correspond to rows in the table
  iii) Attributes of an object correspond to columns from the row
 
 * Active Record - The Object/Relational Mapping (ORM) layer included with Rails is called Active Record. Active Records in Rails provide a connection and interface between relational database tables and Ruby computer code that manipulates database records.

 * Rails Migration - In Ruby on Rails, a migration is a powerful and essential feature that helps developers manage the database schema and make changes to it over time in a structured and organized manner. 
   These are few features provided by rails migration:
    
   i) Database Independence
   ii) Schema Evolution
   iii) Version Control
   iv) Creating Migrations - 
    ```ruby
    rails generate migration CreateProducts
    ```
   v) Editing Migrations
   vi) Running Migrations - 
   ```ruby
   rails db:migrate
   ```
   vii) Rolling Back Migrations -
   ```ruby
   rails db:rollback
   ```
* db/schema.rb - `db/schema.rb` is a special file that serves as a representation of the current state of your application's database schema. It is a Ruby script that defines the structure of your database tables, columns, indexes, and constraints in a human-readable format. 

While doing the initial setup of the database in test or development environment we use this script to setup the database from scratch. 

```ruby
rails db:schema:load
```

In Case you want to export the database schema and data for backup or migration purposes. Rails provides a command to generate a SQL dump of the database based on schema.rb

```ruby
rails db:schema:dump
```

* Naming Convention - Rails will pluralize your class names to find the respective database table. 

Model Class - Singular with the first letter of each word capitalized (e.g., BookClub).
Database Table - Plural with underscores separating words (e.g., book_clubs).

Let's create a new application
```ruby
bin/rails generate controller Articles index --skip-routes --skip-test --skip-system-test
```

Add this gem in Gemfile for writing test cases for model, view controllers etc.
```ruby
gem 'rspec-rails'
```

Add root page in routes.rb
```ruby
root "articles#index"
```

Lets generate a model
```ruby
bin/rails generate model Article title:string body:text
```
Lets run our migration
```ruby
bin/rails db:migrate
``` 

We can create Article either through the rails console or using the seed file.
```ruby 
article = Article.new(title: "Hello Rails", body: "I am on Rails!")
```

```ruby
Article.create(title: "Hello Rails", body: "I am on Rails!")

articles = [
    {title: "Hello Rails", body: "I am on Rails!"},
    {title: "Hello Ruby", body: "I am on Ruby!"},
    {title: "Hello Rspec", body: "I am on Rspec!"}
]

articles.each do |article|
  Article.create(article)
end
```

Run the seed file to add data to the database
```ruby
rails db:seed
```

