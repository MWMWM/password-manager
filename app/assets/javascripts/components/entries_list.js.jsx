var EntriesList = React.createClass({
  render: function() {
    var entries = [];
    this.props.entries.forEach(function(entry) {
      entries.push(<Entry entry={entry} key={'entry' + entry.id}/>);
    }.bind(this));
    return(
      <div className='entries'>
        <div className='header'>
          <div className='basics'>
            <div className='col2'>Site name</div>
            <div className='col2'>Username</div>
          </div>
          <div className='additional'>
            <div className='col2'>Site url</div>
            <div className='col2'>Password</div>
          </div>
        </div>
        {entries}
      </div>
    )
  }
});
