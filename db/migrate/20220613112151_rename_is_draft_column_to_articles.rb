class RenameIsDraftColumnToArticles < ActiveRecord::Migration[6.1]
  def change
    change_column_default :articles, :is_draft, false
  end
end
