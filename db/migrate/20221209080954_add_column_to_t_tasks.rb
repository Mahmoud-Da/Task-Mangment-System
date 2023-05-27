class AddColumnToTTasks < ActiveRecord::Migration[7.0]
  def up
    change_table :tasks do |t|
      t.change :status, :integer, default: 0, null: false, comment: "ステータス"
    end
  end
end
