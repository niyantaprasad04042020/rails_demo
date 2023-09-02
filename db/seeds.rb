articles = [
    {title: "Hello Rails", body: "I am on Rails!"},
    {title: "Hello Ruby", body: "I am on Ruby!"},
    {title: "Hello Rspec", body: "I am on Rspec!"}
]

articles.each do |article|
  Article.create(article)
end
