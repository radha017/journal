class Task < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :name, :body, :date, :user_id, :category_id, presence: true
end
