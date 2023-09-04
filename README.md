# Active Record 

#### ORM
ORM means object relational mapper which is used in ruby on rails that maps the rich set of objects to the tables in the database.
  i) One class for each table in the database
  ii) Objects of the class correspond to rows in the table
  iii) Attributes of an object correspond to columns from the row

#### Active Record
Active Record - The Object/Relational Mapping (ORM) layer included with Rails is called Active Record. Active Records in Rails provide a connection and interface between relational database tables and Ruby computer code that manipulates database records.

#### Rails Migration
Migrations are a convenient way to alter your database schema over time in a consistent way. They use a Ruby DSL so that you don't have to write SQL by hand, allowing your schema and changes to be database independent.
   These are few features provided by rails migration:
    
   * Database Independence
   * Schema Evolution
   * Version Control
   * Creating Migrations - 
   ```ruby
   rails generate migration CreateProducts
   ```
   * Editing Migrations
   * Running Migrations - 
   ```ruby
   rails db:migrate
   ```
   * Rolling Back Migrations -
   ```ruby
   rails db:rollback
   ```
#### db/schema.rb 
`db/schema.rb` is a special file that serves as a representation of the current state of your application's database schema. It is a Ruby script that defines the structure of your database tables, columns, indexes, and constraints in a human-readable format. 

* While doing the initial setup of the database in test or development environment we use this script to setup the database from scratch. 

```ruby
rails db:schema:load
```

* In Case you want to export the database schema and data for backup or migration purposes. Rails provides a command to generate a SQL dump of the database based on schema.rb

```ruby
rails db:schema:dump
```

* Naming Convention - Rails will pluralize your class names to find the respective database table. 

  `Model Class` - Singular with the first letter of each word capitalized (e.g., BookClub).
  `Database Table` - Plural with underscores separating words (e.g., book_clubs).

* Let's create a new application
```ruby
bin/rails generate controller Articles index --skip-routes --skip-test --skip-system-test
```

* Add this gem in Gemfile for writing test cases for model, view controllers etc.
```ruby
gem 'rspec-rails'
```

* Add root page in routes.rb
```ruby
root "articles#index"
```

* Lets generate a model
```ruby
bin/rails generate model Article title:string body:text
```
* Lets run our migration
```ruby
bin/rails db:migrate
``` 

* We can create Article either through the rails console or using the seed file.
```ruby 
article = Article.new(title: "Hello Rails", body: "I am on Rails!")
```

```ruby
Article.create(title: "Hello Rails", body: "I am on Rails!")

articles = [
    {title: "Hello Rails", body: "I am on Rails!", author_id: 1},
    {title: "Hello Ruby", body: "I am on Ruby!", author_id: 1}, 
    {title: "Hello Rspec", body: "I am on Rspec!", author_id: 1}
]

articles.each do |article|
  Article.create(article)
end
```

* Run the seed file to add data to the database
```ruby
rails db:seed
```
# Create a table
```ruby
rails generate migration create_authors
```

* This will create a file in the directory named db/migrate with a timestamp. 
```ruby
class CreateAuthors < ActiveRecord::Migration[6.0]
  def change
    create_table :authors do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone_no
      t.text :about
      t.timestamps
    end
  end
end
```

* To update the changes defined in the migration 
```ruby
rails db:migrate
```

* To add the reference of author in the article we can use the following migration
```ruby
rails g migration AddAuthorRefToArticle author:references
```
# Types of JOINS in rails
A join clause is used to combine rows from two or more tables, based on a related column between them.

* INNER JOIN

It returns the dataset that has matching values in both the tables.

SELECT column_name FROM table1 INNER JOIN table2 WHERE table1.column_name = table2.column_name

```ruby
User.joins(:posts)
```

* Left Join

It returns all the dataset from the left of the table and the matching record from the right table.

SELECT column_name FROM table1 LEFT JOIN table2 where table1.column_name = table2.column_name

```ruby
User.left_joins(:posts)
```


### find
Using the find method, you can retrieve the object corresponding to the specified primary key that matches any supplied options.
```ruby
Author.find(1)
Author.find([1, 2])

# SQL
ActiveRecord::Base.connection.execute("SELECT * FROM authors WHERE (authors.id = 1)")
ActiveRecord::Base.connection.execute("SELECT * FROM authors WHERE (authors.id IN [1, 2])")
```
### take
The take method retrieves a record without any implicit ordering.
```ruby
Author.take
Author.take(2)

# SQL
ActiveRecord::Base.connection.execute("SELECT * FROM authors LIMIT 1")
ActiveRecord::Base.connection.execute("SELECT * FROM authors LIMIT 2")
```
### take!
The take! method behaves exactly like take, except that it will raise ActiveRecord::RecordNotFound if no matching record is found.

### first
The first method finds the first record in a database table based on the primary key

```ruby
Author.first
Author.first(3)

# SQL
ActiveRecord::Base.connection.execute("SELECT * FROM authors ORDER BY authors.id ASC LIMIT 1")
ActiveRecord::Base.connection.execute("SELECT * FROM authors ORDER BY authors.id ASC LIMIT 3")
```

#### first!
The first! method behaves exactly like first, except that it will raise ActiveRecord::RecordNotFound if no matching record is found.

### last
The last method finds the last record in tha database table ordered by the primary key

```ruby
Author.last
Author.last(3)

ActiveRecord::Base.connection.execute("SELECT * FROM authors ORDER BY authors.id DSC LIMIT 1")
ActiveRecord::Base.connection.execute("SELECT * FROM authors ORDER BY authors.id DSC LIMIT 3")
```

### last!
The last! method behaves exactly like last, except that it will raise ActiveRecord::RecordNotFound if no matching record is found.

### find_by
The find_by method finds records in database table based on some matching condition.

```ruby
Author.find_by(first_name: "Niyanta")
Author.find_by(first_name: "Niyanta").take()

ActiveRecord::Base.connection.execute('SELECT * FROM authors WHERE (authors.first_name = "Niyanta")')
ActiveRecord::Base.connection.execute('SELECT * FROM authors WHERE (authors.first_name = "Niyanta")LIMIT 1')
```
### find_by!
This find_by method also finds the records of the database table based on some matching condition but throw the exception ActiveRecord:RecordNotFound error when no matching records are found.

### find_each
It is used to retrieve revords in a batch of 1000 and the yields each on to the block for processing.

```ruby
Author.find_each(batch: 1000, start: 2000, finish: 10000, order: :desc) do |author|
  Article.where(author_id: author.id).deliver_now
end
```

### find_in_batches
The find_in_batches method yeilds array of models as batches to the block for processing.

```ruby
Author.find_in_batches(size: 200, start: 2000, finish: 10000) do |authors|
  export.find_books(authors)
end
```

### Array Condition
```ruby
Author.where("first_name = ? AND last_name = ?", params[:first_name], params[:last_name])
```

### PlaceHolder Condition

```ruby
Article.where("created_at >= :start_date AND created_at <= :end_date", start_date: params[:start_date], end_date: params[:end_date])
```

###  Conditions That Use LIKE
```ruby
Article.where("title LIKE ?", params[:title] + "%")
# The problem is that whenever we have % or _ within the params[:title] it returns very unexpected records. To resolve this we can use sanitze_sql_like which uses escape character to escape the occurence of letters like % or _
Article.where("title LIKE ?", Article.sanitiza_sql_like(params[:title] + "%"))











