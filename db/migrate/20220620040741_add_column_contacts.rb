class AddColumnContacts < ActiveRecord::Migration[6.1]
  def change
    add_column :contacts, :user_id, :integer
  end
end
