var Entry= React.createClass({
  getDetailsFromApi: function(entry_id) {
    var self = this;
    $.ajax({
      url: '/api/v1/password_entries/' + entry_id,
      success: function(data) {
        ReactDOM.render(<Details details={data} />,
                        document.getElementById('details-'+ data.id));
      },
      error: function(xhr, status, error) {
        console.log('Cannot get data from API: ', error);
      }
    });
  },
  render: function() {
    var entry = this.props.entry;
    return(
      <div className='entry' id={'entry-' + entry.id} >
        <div className='basics'>
          <a className='clickable' onClick={() => this.getDetailsFromApi(entry.id)}>
            <div className='col50'>{entry.site_name}</div>
            <div className='col50'>{entry.username}</div>
          </a>
        </div>
        <div className='additional' id={'details-' + entry.id}>
        </div>
      </div>
    )
  }
});
