class TodoTimeBlocksInput extends React.Component {
  render() {
    var activeCircles = []
    for (var i=0; i < this.props.actualTimeBlocks; i++) {
      activeCircles.push(<span className="pomodoroCircle active"></span>)
    }

    var inactiveCircles = []
    for (var i=0; i < (5 - this.props.actualTimeBlocks); i++) {
      inactiveCircles.push(<span className="pomodoroCircle"></span>)
    }

    return (
      <div
        className="todoPomodoros"
        onClick={this._onClick.bind(this)}>
        { activeCircles }
        { inactiveCircles }
      </div>
    );
  }

  _onClick(e) {
    if (this.props.actualTimeBlocks < 5) {
      this.props.onClick({target: {value: this.props.actualTimeBlocks + 1}})
    } else {
      this.props.onClick({target: {value: 0}})
    }
  }
}

TodoTimeBlocksInput.propTypes = {
  actualTimeBlocks: React.PropTypes.node.isRequired,
  onClick: React.PropTypes.func.isRequired
};
