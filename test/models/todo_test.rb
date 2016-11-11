require 'test_helper'

class TodoTest < ActiveSupport::TestCase
  test '.frontend_info' do
    assert(Todo.frontend_info.first == todos(:get_groceries))
  end
end
