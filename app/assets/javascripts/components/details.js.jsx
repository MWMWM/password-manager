var Details= React.createClass({
  getSharingUrlFromApi: function(entry_id) {
    var self = this;
    $.ajax({
      url: '/api/v1/password_entries/' + entry_id + '/generate_sharing',
      success: function(data) {
        ReactDOM.render(<SharingUrl data={data} />,
                        document.getElementById('sharingUrl'+ data.id));
      },
      error: function(xhr, status, error) {
        console.log('Cannot get data from API: ', error);
      }
    });
  },
  render: function() {
    var details = this.props.details;
    return(
      <span className='details'>
        <div className='col20'>
          <a href={details.site_url} target='_blank'>{details.site_url}</a>
        </div>
        <div className='col40'>
          {details.decrypted_password}
        </div>
        <div className='col40 sharingUrl' id={'sharingUrl' + details.id}>
          <a onClick={() => this.getSharingUrlFromApi(details.id)}>
            <button>
              Generate sharing link
            </button>
          </a>
        </div>
      </span>
    )
  }
});
