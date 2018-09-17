$(document).ready(function () {
  var peopleTable = $("#people-table").DataTable({
    "paging": false,
    "info": false,
    "searching": false,
    "columnDefs": [
      {
        "type": "html", "targets": 3, "render": function (data, type, row) {
          if (data === 'None') {
            return "<span class='no-pet'>" + data + "</span>"
          } else {
            return "<img class='pet-image' src='/assets/" + data.toLowerCase() + ".png'/> " + data;
          }
        }
      },
      { "type": "date", "targets": 4 }
    ]
  });

  $('#people_form').ajaxForm({
    url: '/people/upload',
    dataType: 'json',
    success: function (response) {
      if (response.errors && response.errors.length > 0) {
        response.errors.forEach(function (error) {
          $("#error-list").append("<li>" + error + "</li>");
        });
        $("#error-list").show();
      }

      if (response.people && response.people.length > 0) {
        response.people.forEach(function (person) {
          peopleTable.row.add([
            person.first_name,
            person.last_name,
            person.middle_initial,
            person.pet,
            person.dob,
            person.favorite_color
          ]).draw(true);
        });
        $('#num-people').text(peopleTable.rows().count());
      }
    }, error: function (error) {
      console.log(error);
      $("#error-list").append("<li>" + error + "</li>");
      $("#error-list").show();
    }
  });

  $("#people_upload").change(function (event) {
    var fileName = event.target.files[0].name;
    $("#file_name").val(fileName);
    $('#people_form').submit();
    $("#error-list").html('');
    $("#error-list").hide();
  });
});
