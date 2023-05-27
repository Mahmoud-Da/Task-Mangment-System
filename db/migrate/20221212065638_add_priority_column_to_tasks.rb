class AddPriorityColumnToTasks < ActiveRecord::Migration[7.0]
  def change
    add_column :tasks, :priority, :integer, default: 1, null: false, comment: "優先度"
    change_column_null(:tasks, :limit, false)
  end
end
