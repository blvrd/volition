class TodoList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      todos: this.props.todos
    }
  }

  render() {
    var todos = this.state.todos.map((todo, index) => {
      return (
        <Todo
          todo={todo}
          index={index}
          updateTodo={this.updateTodo.bind(this)}
          key={index} />
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

  updateTodo(index, inputType, e) {
    newTodoState = update(this.state.todos, {
      [index]: { [inputType]: {$set: e.target.value} }
    })

    this.setState({todos: newTodoState})
  }
}

TodoList.propTypes = {
  todos: React.PropTypes.array
};

