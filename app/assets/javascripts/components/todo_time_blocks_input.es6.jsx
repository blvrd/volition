class TodoTimeBlocksInput extends React.Component {
  render() {
    var activeCircles = []
    for (var i=0; i < this.props.actualTimeBlocks; i++) {
      activeCircles.push(<span key={`active${i}`} className="pomodoroCircle active"></span>)
    }

    var numberInactive = 5 - this.props.actualTimeBlocks
    var inactiveCircles = []
    for (var i=0; i < numberInactive; i++) {
      var classList = ['pomodoroCircle']
      if ((this.props.actualTimeBlocks + i) < this.props.estimatedTimeBlocks) {
        classList.push('estimated')
      }

      inactiveCircles.push(<span key={`inactive${i}`} className={classList.join(' ')}></span>)
    }

    return (
      <div
        className="todoPomodoros"
        onClick={this._onClick.bind(this)}>
        { activeCircles }
        { inactiveCircles }
        <span className={`hoverEstimate ${this.props.estimatedTimeBlocks > 0 ? '': 'hidden'}`}>Estimated: {this.props.estimatedTimeBlocks}</span>
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
