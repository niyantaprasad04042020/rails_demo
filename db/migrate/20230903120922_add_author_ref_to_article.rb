class AddAuthorRefToArticle < ActiveRecord::Migration[6.1]
  def change
    add_reference :articles, :author, null: false, foreign_key: true
  end
end
