class Todo extends React.Component {
  render() {
    var todo = this.props.todo

    return (
      <li className="todo">
        <TodoCompleteInput
          complete={todo.complete}
          onChange={this.updateTodo.bind(this, this.props.index, 'complete')}
          index={this.props.index} />
        <TodoContentInput
          content={todo.content}
          onChange={this.updateTodo.bind(this, this.props.index, 'content')} />
        <TodoTimeBlocksInput
          actualTimeBlocks={todo.actual_time_blocks}
          onClick={this.updateTodo.bind(this, this.props.index, 'actual_time_blocks')} />
      </li>
    );
  }

  updateTodo(index, inputType, e) {
    this.props.updateTodo(index, inputType, e)
  }

}

Todo.propTypes = {
  todo:          React.PropTypes.object.isRequired,
  index:         React.PropTypes.number.isRequired,
  updateTodo:    React.PropTypes.func.isRequired
};
