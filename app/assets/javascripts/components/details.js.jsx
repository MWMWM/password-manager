var Details= React.createClass({
  render: function() {
    var details = this.props.details;
    return(
      <span className='details'>
        <div className='col2'>
          <a href={details.site_url} target='_blank'>{details.site_url}</a>
        </div>
        <div className='col2'>
          {details.decrypted_password}
        </div>
      </span>
    )
  }
});
