function handle_destroy(id) {
  if(confirm("Are you sure?")) {
    $.ajax({
      url: '/' + id,
      type: 'DELETE',
    });
  };
  return false;
}