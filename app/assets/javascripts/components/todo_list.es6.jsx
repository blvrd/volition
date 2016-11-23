class TodoList extends React.Component {
  constructor(props) {
    super(props)
    this.state = {
      todos: this.props.todos,
      recentlySaved: false
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
        <div className={`recentlySaved ${this.state.recentlySaved ? '' : 'invisible'}`}>Saved</div>
        <li className="todoLabels">
          <span className="todoLabel">Complete</span>
          <span className="todoLabel">25 minute blocks</span>
        </li>

        { todos }
      </ul>
    );
  }

  updateTodo(index, inputType, e) {
    var todo = this.state.todos[index]
    if (todo.content.length === 0 && inputType !== 'content') { return; }

    var newTodoState = update(this.state.todos, {
      [index]: {
        [inputType]: {$set: e.target.value}
      }
    })

    this.setState({todos: newTodoState}, () => {
      var todo = this.state.todos[index]

      $.ajax({
        url: `/todos/${todo.id}`,
        method: 'PUT',
        data: {
          todo: todo
        },
        success: (data) => {
          if (data.saved) {
            this.setRecentlySaved()
          } else {
            console.log(data)
          }
        }
      })
    })
  }

  setRecentlySaved() {
    this.setState({recentlySaved: true}, () => {
      setTimeout(this.removeRecentlySaved.bind(this), 3000)
    })
  }

  removeRecentlySaved() {
    this.setState({recentlySaved: false})
  }
}

TodoList.propTypes = {
  todos: React.PropTypes.array
};

