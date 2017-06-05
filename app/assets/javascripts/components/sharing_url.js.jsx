var SharingUrl= React.createClass({
  render: function() {
    var data = this.props.data;
    host = location.protocol + '//' + window.location.hostname
    return (
        <span>
          {host}/api/v1/password_entries/{data.id}/sharings/{data.new_sharing_token}
        </span>
        )
  }
})
