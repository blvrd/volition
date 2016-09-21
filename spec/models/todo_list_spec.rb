require 'rails_helper'

describe TodoList do
  let!(:user)        { create(:user) }
  let!(:todo_list_1) { create(:todo_list, user: user, date: Date.today) }
  let!(:todo_list_2) { create(:todo_list, user: user, date: Date.today.prev_day) }
  let!(:todo_list_3) { create(:todo_list, user: user, date: Date.today.prev_day.prev_day) }
  let!(:todo_list_4) { create(:todo_list, user: user, date: Date.today.next_day) }

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
