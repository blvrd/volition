class MockupsController < ApplicationController
  def week_plan
    @todo_list  = TodoList.last
  end
end
