class CreateTaskCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :task_categories do |t|
      t.belongs_to :task
      t.belongs_to :category
      t.timestamps
    end
  end
end
