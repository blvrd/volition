class User < ApplicationRecord
  has_many :reflections
  has_many :todo_lists
  has_many :todos, through: :todo_lists
end
