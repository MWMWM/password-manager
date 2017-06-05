var Entry= React.createClass({
  getInitialState: function() {
    return { details: [] };
  },
  getDetailsFromApi: function(entry_id) {
    var self = this;
    $.ajax({
      url: '/api/v1/password_entries/' + entry_id,
      success: function(data) {
        self.setState({ details: data });
      },
      error: function(xhr, status, error) {
        console.log('Cannot get data from API: ', error);
      }
    });
  },
  render: function() {
    var entry = this.props.entry;
    return(
      <div className='entry'>
        <div className='basics'>
          <a className='clickable' onClick={() => this.getDetailsFromApi(entry.id)}>
            <div className='col2'>{entry.site_name}</div>
            <div className='col2'>{entry.username}</div>
          </a>
        </div>
        <DetailsList details={this.state.details} />
      </div>
    )
  }
});
