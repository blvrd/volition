class DaysController < AuthenticatedController
  def show
    @todo_list = current_user.daily_snapshots.find_by(id: params[:id])
    @reflection = @todo_list.reflection
  end
end
