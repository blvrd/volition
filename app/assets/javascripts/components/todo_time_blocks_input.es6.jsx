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
      this.burstAnimation(e)
    } else {
      this.props.onClick({target: {value: 0}})
    }
  }

  burstAnimation(e) {
    var burst = new mojs.Burst({
      left: 0,
      top: 0,
      radius:   { 0: 50 },
      count:   10,
      children: {
        shape:        'circle',
        radius:       8,
        fill:         [ '#49be5a'],
        strokeWidth:  2,
        duration:     2000
      }
    });

    var $section = $(e.target).closest('.todoPomodoros')

    if ($section.find('.pomodoroCircle.active').length > 0) {
      var $nextInactiveCircle = $section.find('.pomodoroCircle.active').last().next('.pomodoroCircle')
    } else {
      var $nextInactiveCircle = $section.find('.pomodoroCircle').first()
    }

    burst
    .tune({ x: $nextInactiveCircle.offset().left + 10, y: $nextInactiveCircle.offset().top + 8 })
    .setSpeed(3)
    .replay();
  }
}

TodoTimeBlocksInput.propTypes = {
  actualTimeBlocks: React.PropTypes.node.isRequired,
  onClick: React.PropTypes.func.isRequired
};
