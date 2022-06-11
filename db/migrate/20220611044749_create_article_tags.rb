class CreateArticleTags < ActiveRecord::Migration[6.1]
  def change
    create_table :article_tags do |t|

      t.integer :article_id, null: false
      t.integer :tag_id, null: false

      t.timestamps
    end
  end
end
