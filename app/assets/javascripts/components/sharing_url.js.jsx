var SharingUrl= React.createClass({
  render: function() {
    var data = this.props.data;
    host = location.protocol + '//' + window.location.hostname
    return (
        <span>
          {host}/api/v1/password_entries/{data.id}/use_sharing?token={data.generate_sharing_token}
        </span>
        )
  }
})
