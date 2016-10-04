require 'rails_helper'

describe User do
  describe '#had_a_great_day?' do
    let!(:user) { create(:user) }

    context 'not a great day' do
      let!(:reflection) { create(:reflection, user: user, rating: 6, date: Date.current) }
      let!(:todo_list) { create(:todo_list, user: user, date: Date.current.next_day) }

      it 'should return false' do
        expect(user.had_a_great_day?).to eq(false)
      end
    end

    context 'great day' do
      let!(:reflection) { create(:reflection, user: user, rating: 10, date: Date.current) }
      let!(:todo_list) { create(:todo_list, user: user, date: Date.current.next_day) }

      it 'should return true' do
        expect(user.had_a_great_day?).to eq(true)
      end
    end

  end
end
