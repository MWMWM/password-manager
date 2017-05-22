var Entry= React.createClass({
  propTypes: {
    site_name: React.PropTypes.string,
    site_url: React.PropTypes.string,
    username: React.PropTypes.string,
    decrypted_password: React.PropTypes.string,
  },
  render: function() {
    var entry = this.props.entry;
    return(
       <p>{entry.site_name}</p>
    )
  }
});
