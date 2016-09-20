class TodoCompleteInput extends React.Component {
  render() {
    return (
      <div className="todoComplete">
        <div className="checkbox">
          <input
            className="completeInput"
            id={`complete${this.props.index}`}
            type="checkbox"
            onChange={this._onChange.bind(this)}
            checked={this.props.complete} />
          <label htmlFor={`complete${this.props.index}`}></label>
        </div>
      </div>
    );
  }

  _onChange(e) {
    if (this.props.complete) {
      this.props.onChange({target: {value: false}})
    } else {
      this.props.onChange({target: {value: true}})
    }
  }
}

TodoCompleteInput.propTypes = {
  complete: React.PropTypes.bool.isRequired,
  onChange: React.PropTypes.func.isRequired,
  index: React.PropTypes.number.isRequired
};
