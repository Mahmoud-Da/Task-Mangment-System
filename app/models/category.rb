class Category < ApplicationRecord
  has_many :task_categories, dependent: :destroy
  has_many :tasks, through: :task_categories
  with_options presence: true do
    validates :name
  end
end
