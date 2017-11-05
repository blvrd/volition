class TodosController < AuthenticatedController
  protect_from_forgery except: [:update]

  def update
    @todo = Todo.find_by(id: params[:id])

    begin
      @todo.update!(todo_params)

      todo_in_week_plan = current_week_plan.todos.find_by(content: @todo.content)

      if todo_in_week_plan.present?
        todo_in_week_plan.destroy
      end

      render json: { saved: true }
    rescue => e
      puts e
      render json: { saved: false }, status: :unprocessable_entity
    end

  end

  private

  def todo_params
    params.require(:todo)
          .permit(:content, :complete, :actual_time_blocks, :estimated_time_blocks, :id)
  end
end
