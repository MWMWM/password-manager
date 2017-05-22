var PasswordEntriesList = React.createClass({
  render: function() {
    var entries = [];
    this.props.entries.forEach(function(entry) {
      entries.push(<Entry entry={entry}
                         key={'entry' + entry.id}/>);
    }.bind(this));
    return(
      <div>
        {entries}
      </div>
    )
}
});
