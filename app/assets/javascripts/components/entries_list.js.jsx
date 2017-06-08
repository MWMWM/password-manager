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
            <div className='col50'>Site name</div>
            <div className='col50'>Username</div>
          </div>
          <div className='additional'>
            <div className='col20'>Site url</div>
            <div className='col40'>Password</div>
            <div className='col40'>SharingUrl</div>
          </div>
        </div>
        {entries}
      </div>
    )
  }
});
