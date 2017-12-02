// Template literal for clients table header
var tableHeader = `
  <table class="table">
    <tr class="header-row">
      <th class="column-header">Client:</th>
      <th class="column-header"></th>
      <th><th>
    </tr>
  </table>
`

// Create Client prototype, set attributes dynamically
function Client(attributes) {
  for (var key in attributes) {
    this[key] = attributes[key]
  }
}

// Take JS model objects and create table rows from them
Client.prototype.clientIndexFormatter = function() {
  return `
    <tr>
      <td><a href="/clients/${this.id}">${this.name}</a></td>
      <td><button class="btn btn-default app" data-id="${this.id}">Show Next Appointment:</button></td>
    </tr>
    <tr class="app-row-${this.id}">
      <td>${moment(this.appointment).format('LLL')}</td>
      <td></td>
    </tr>
  `
}

// Renders client provided by getClient()
Client.prototype.renderClientShow = function() {
  changeShowIdValues(this.id);
  this.renderClientStats();  
  this.renderClientProgress();
  this.renderClientNotes();
}

// Render new client stats in locations of old client stats
Client.prototype.renderClientStats = function() {
  $('#client-name').html(this.name);
  $('#email').html(`Email: ${this.email}`);
  $('#phone').html(`Phone: ${this.phone}`);
  $('#age').html(`Age: ${this.age}`);
  $('#weight').html(`Current Weight: ${this.weight}`);
  $('#goal').html(`Goal: ${this.goal}`);
  $('.note-header').html(`Add a Note For ${this.name}:`);
}

// Render client progress based on client goal
Client.prototype.renderClientProgress = function() {
  if (this.goal === "Lose Weight") {
    $('#progress').html(`Progress: ${this.progress} lbs. Lost`);
  } else {
    $('#progress').html(`Progress: ${this.progress} lbs. Gained`);
  }
}

// Render notes belonging to client
Client.prototype.renderClientNotes = function() {
  $('.notes-list').empty();
  this.notes.forEach(n => {
    $('.notes-list').append(`<li>${[n.text]}</li>`);
  })
}

$(function() {
  // Hide ".most" div on page load
  $('.most').hide();
  // Load Client index resource
  $('a.load_clients').on('click', function(e) {
    e.preventDefault();
    $('.index-header').html("Your Clients:");
    $('.most').show();
    // Render tableHeader template to page
    $('.index-list').html(tableHeader);
    $.get("/clients.json", function(data) {
      data.forEach(clientAttributes => {
        // Translate JSON responses to JS model objects
        const newClient = new Client(clientAttributes);
        $('tbody').append(newClient.clientIndexFormatter());
        $(`.app-row-${newClient.id}`).hide();
      })
      // Reveal has_many relationship with appointment
      $('.btn.btn-default.app').on('click', function() {
        toggleAppointment(this.dataset.id);
      })
    }) 
  })
  
  // Create and render Note resource w/o page refresh
  $('#note-form').on('submit', function(e) {
    e.preventDefault();
    var form = this;
    var action = $(this).attr("action");
    var params = $(this).serialize();
    $.post(action, params)
      .done(function(response) {
        $('#ajax_submit').attr("disabled", false);
        var note = `<li>${response["text"]}</li>`;
        $('.notes-list').append(note);
        // Resets form
        form.reset();
      })
  })

  // Delete all Note objects that belong_to Client without page refresh
  $('#clear-notes').on('click', function() {
    var clientId = this.dataset.id;
    $.ajax({
      url: '/notes',
      type: 'DELETE',
      data: {
        client_id: clientId
      },
      success: function() {
        $('.notes-list').empty();
      }
    });
  })

  // Render Client show page
  $('.btn.btn-secondary.btn-sm').on('click', function() {
    var action = this.id;
    var clientId =  parseInt(this.dataset.id);
    var idArray = [];
    $.get('/clients.json', function(data) {
      // Get id's of all clients and push into array
      data.forEach(c => {
        idArray.push(c.id);
      })
      // Call function based on whether "next" or "previous" was clicked
      if (action === "next") {
        getNext(clientId, idArray);
      } else {
        getPrevious(clientId, idArray);
      }
    })
  })
})

// Reveal has_many relationship with appointment
function toggleAppointment(id) {
  $(`.app-row-${id}`).toggle();
}

// Get next client id of client to be rendered, guards against missing client id's (1 > 2 > 4, etc...)
function getNext(id, array) {
  var next = id + 1;
  while (next <= array[array.length - 1]) {
    if (array.includes(next)) {
      getClient(next);
      break;
    } else {
      ++next;
    }
  }
}

// Get next client id of client to be rendered (backwards), guards against missing client id's 
// (5 > 4 > 2, etc...)
function getPrevious(id, array) {
  var descArray = array.reverse();
  var prev = id - 1;
  while (prev >= descArray[descArray.length - 1]) {
    if (descArray.includes(prev)) {
      getClient(prev);
      break;
    } else {
      --prev;
    }
  }
}

// Gets client from server using provided id from getNext or getPrevious
function getClient(id) {
  $.get("/clients/" + id + ".json", function(data) {
    const client = new Client(data);
    client.renderClientShow();
  })
}

// Change id values in elements to reflect those of new rendered client
function changeShowIdValues(id) {
  $('#previous').attr("data-id", id);
  $('#next').attr("data-id", id);
  $('#edit-client').attr("href", "/clients/" + id + "/edit");
  $('#remove-client').attr("href", "/clients/" + id);
  $('#note_client_id').attr("value", id);
  $('#clear-notes').attr("data-id", id);
}
