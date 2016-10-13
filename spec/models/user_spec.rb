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

  describe '#recently_signed_up?' do

    context 'not recently signed up' do
      let!(:user) { create(:user) }

      it 'should return false' do
        Timecop.travel(1.day.from_now) do
          expect(user.recently_signed_up?).to eq(false)
        end

      end
    end

    context 'recently signed up' do
      let!(:user) { create(:user) }

      it 'should return true' do
        expect(user.recently_signed_up?).to eq(true)
      end
    end

  end
end
