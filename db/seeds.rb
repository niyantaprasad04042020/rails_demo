articles = [
    {title: "Hello Rails", body: "I am on Rails!", author_id: 1},
    {title: "Hello Ruby", body: "I am on Ruby!", author_id: 1},
    {title: "Hello Rspec", body: "I am on Rspec!", author_id: 1}
]

articles.each do |article|
  Article.create(article)
end
