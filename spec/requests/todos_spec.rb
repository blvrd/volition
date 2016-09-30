require 'rails_helper'

describe 'Todos API', type: :request do
  let!(:user)      { create(:user) }
  let!(:todo_list) { create(:todo_list, user: user) }
  let!(:todo)      { create(:todo, todo_list: todo_list) }

  describe '[PUT] Todos#update' do
    context 'success' do
      it 'should update the todo' do
        params = {
          todo: {
            content: 'Write blog post.',
            complete: true
          }
        }

        put "/todos/#{todo.id}", params: params

        expect(response.status).to eq(200)
        expect(todo.reload.content).to eq('Write blog post.')
      end
    end

    context 'failure' do
      it 'should update the todo' do
        params = {
          bad_param: true
        }

        put "/todos/#{todo.id}", params: params

        expect(response.status).to eq(422)
      end
    end

  end
end
