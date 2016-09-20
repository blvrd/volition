class TodoContentInput extends React.Component {
  render () {
    return (
      <div className="todoContent">
        <input
          className="contentInput"
          type="text"
          value={this.props.content}
          onChange={this._onChange.bind(this)} />
      </div>
    );
  }

  _onChange(e) {
    this.props.onChange(e)
  }
}

TodoContentInput.propTypes = {
  content: React.PropTypes.string.isRequired,
  onChange: React.PropTypes.func.isRequired
};
