class DaysController < AuthenticatedController
  def show
    @daily_snapshot = current_user.daily_snapshots.find_by(date: params[:date])
    @reflection = @daily_snapshot.reflection
  end
end
