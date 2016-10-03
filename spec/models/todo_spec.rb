require 'rails_helper'

describe Todo do
  let!(:user)      { create(:user) }
  let!(:todo_list) { create(:todo_list, user: user) }
  let!(:todo)      { create(:todo, todo_list: todo_list) }

  describe '.frontend_info' do
    it 'should only return columns to use in frontend' do
      expect(Todo.frontend_info.first).to eq(todo)
    end
  end

end
