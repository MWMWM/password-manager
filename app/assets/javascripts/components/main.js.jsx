var Main = React.createClass({
  getInitialState: function() {
    return { entries: [] };
  },
  componentDidMount: function() {
    this.getDataFromApi();
  },
  getDataFromApi: function() {
    var self = this;
    $.ajax({
      url: '/api/v1/password_entries',
      success: function(data) {
        self.setState({ entries: data });
      },
      error: function(xhr, status, error) {
        console.log('Cannot get data from API: ', error);
      }
    });
  },
  render: function() {
    return(
      <div className='container'>
        <h1>Your passwords</h1>
        <EntriesList entries={this.state.entries} />
      </div>
    )
  }
});
