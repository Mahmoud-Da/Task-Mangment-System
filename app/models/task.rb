class Task < ApplicationRecord
  has_many :task_categories, dependent: :destroy
  has_many :categories, through: :task_categories
  with_options presence: true do
    validates :title
    validates :limit
  end

  enum status: { not_started: 0, started: 1, completed: 2 }
  enum priority: { low: 0, medium: 1, high: 2 }

  default_scope { order('tasks.priority DESC') }
end
