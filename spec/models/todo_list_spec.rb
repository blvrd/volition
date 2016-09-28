require 'rails_helper'

describe TodoList do
  let!(:user)         { create(:user) }
  let!(:todo_list_1)  { create(:todo_list, user: user, date: Date.current) }
  let!(:todo_list_2)  { create(:todo_list, user: user, date: Date.current.prev_day) }
  let!(:todo_list_3)  { create(:todo_list, user: user, date: Date.current.prev_day.prev_day) }
  let!(:todo_list_4)  { create(:todo_list, user: user, date: Date.current.next_day) }
  let!(:current_time) { DateTime.now.change({ hour: 20 }) }

  around(:example) do |spec|
    Time.use_zone('Central Time (US & Canada)') do
      Timecop.travel(current_time) do
        spec.run
      end
    end
  end

  describe '.today' do
    it 'should return the todo list for today' do
      expect(TodoList.today(user)).to eq(todo_list_1)
    end
  end

  describe '.past' do
    it 'should return the past todo lists in descending date order' do
      expect(TodoList.past(user)).to eq([todo_list_2, todo_list_3])
    end
  end
end
