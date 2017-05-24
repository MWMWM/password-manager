var DetailsList= React.createClass({
  render: function() {
    var details = [];
    details.push(<Details details={this.props.details}
                         key={'details' + this.props.details.id}/>);
    return(
      <div className='additional'>
        {details}
      </div>
    )
  }
});
