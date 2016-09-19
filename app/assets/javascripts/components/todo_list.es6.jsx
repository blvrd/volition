class TodoList extends React.Component {
  render () {
    var todos = this.props.todos.map((todo, index) => {
      return (
        <li className="todo" key={index}>
          <div className="todoComplete">
            <div className="checkbox">
              <input className="completeInput" id={`complete${index}`} type="checkbox" />
              <label htmlFor={`complete${index}`}></label>
            </div>
          </div>
          <div className="todoContent"><input className="contentInput" type="text" value={todo.content} /></div>
          <div className="todoPomodoros">
            <span className="pomodoroCircle"></span>
            <span className="pomodoroCircle"></span>
            <span className="pomodoroCircle"></span>
            <span className="pomodoroCircle"></span>
            <span className="pomodoroCircle"></span>
          </div>
        </li>
      )
    })
    return (
      <ul className="todoList">
        <li className="todoLabels">
          <span className="todoLabel">Complete</span>
          <span className="todoLabel">25 minute blocks</span>
        </li>

        { todos }
      </ul>
    );
  }
}

TodoList.propTypes = {
  todos: React.PropTypes.array
};

