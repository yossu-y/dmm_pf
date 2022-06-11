class CreateArticles < ActiveRecord::Migration[6.1]
  def change
    create_table :articles do |t|

      t.integer:user_id, null: false
      t.string :title, null: false
      t.boolean :is_draft

      t.timestamps
    end
  end
end
