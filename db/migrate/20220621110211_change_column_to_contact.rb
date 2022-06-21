class ChangeColumnToContact < ActiveRecord::Migration[6.1]
  def change
    change_column_default :contacts, :progress_status, 0
  end
end
