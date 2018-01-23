# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

user = User.create(
  name: 'Garrett Martin',
  email: 'garrett@example.com'
)

list_1 = TodoList.create(
  user: user,
  date: Date.today
)

list_2 = TodoList.create(
  user: user,
  date: Date.today.prev_day
)

5.times do
  Todo.create(
    content: 'Read a book.',
    estimated_time_blocks: 5,
    actual_time_blocks: 4,
    daily_todo_list: list_1,
    complete: false
  )
end

5.times do
  Todo.create(
    content: 'Follow up with client',
    estimated_time_blocks: 3,
    actual_time_blocks: 4,
    daily_todo_list: list_2,
    complete: true
  )
end

Reflection.create(
  user: user,
  rating: 8,
  date: Date.today.prev_day
)
