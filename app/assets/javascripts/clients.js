var tableHeader = `
  <table class="table">
    <tr class="header-row">
      <th class="column-header">Client:</th>
      <th class="column-header"></th>
      <th><th>
    </tr>
  </table>
`

class Client {
  constructor(id, name, email, phone, age, weight, goal, appointment, progress, notes) {
    this.id = id
    this.name = name
    this.email = email
    this.phone = phone
    this.age = age
    this.weight = weight
    this.goal = goal
    this.appointment = appointment
    this.progress = progress
    this.notes = notes
  }
}

Client.prototype.clientIndexFormatter = function() {
  return `
    <tr>
      <td><a href="/clients/${this.id}">${this.name}</a></td>
      <td><button class="btn btn-default" onClick="toggleAppointment(${this.id})">Show Next Appointment:</button></td>
    </tr>
    <tr class="app-row-${this.id}">
      <td>${moment(this.appointment).format('LLL')}</td>
      <td></td>
    </tr>
  `
}

Client.prototype.renderClientShow = function() {
  changeShowIdValues(this.id);
  this.renderClientStats();  
  this.renderClientProgress();
  this.renderClientNotes();
}

Client.prototype.renderClientStats = function() {
  $('#client-name').html(this.name);
  $('#email').html(`Email: ${this.email}`);
  $('#phone').html(`Phone: ${this.phone}`);
  $('#age').html(`Age: ${this.age}`);
  $('#weight').html(`Current Weight: ${this.weight}`);
  $('#goal').html(`Goal: ${this.goal}`);
  $('.note-header').html(`Add a Note For ${this.name}:`);
}

Client.prototype.renderClientProgress = function() {
  if (this.goal === "Lose Weight") {
    $('#progress').html(`Progress: ${this.progress} lbs. Lost`);
  } else {
    $('#progress').html(`Progress: ${this.progress} lbs. Gained`);
  }
}

Client.prototype.renderClientNotes = function() {
  $('.notes-list').empty();
  this.notes.forEach(n => {
    $('.notes-list').append(`<li>${[n.text]}</li>`);
  })
}

$(function() {
  $('.most').hide();
  $('a.load_clients').on('click', function(e) {
    e.preventDefault();
    $('.index-header').html("Your Clients:");
    $('.most').show();
    $('.index-list').html(tableHeader);
    $.get("/clients.json", function(data) {
      data.forEach(c => {
        const newClient = new Client(c.id, c.name, c.email, c.phone, c.age, c.weight,
        c.goal, c.appointments[0].date, c.progress);
        $('tbody').append(newClient.clientIndexFormatter());
        $(`.app-row-${newClient.id}`).hide();
      })
    })
  })
  
  $('#note-form').on('submit', function(e) {
    e.preventDefault();
    var action = $(this).attr("action");
    var params = $(this).serialize();
    $.post(action, params)
      .done(function(response) {
        $('#ajax_submit').attr("disabled", false);
        var note = `<li>${response["text"]}</li>`;
        $('.notes-list').append(note);
      })
  })

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

  $('.btn.btn-secondary.btn-sm').on('click', function() {
    var action = this.id;
    var clientId =  parseInt(this.dataset.id);
    var idArray = [];
    $.get('/clients.json', function(data) {
      data.forEach(c => {
        idArray.push(c.id);
      })
      if (action === "next") {
        getNext(clientId, idArray);
      } else {
        getPrevious(clientId, idArray);
      }
    })
  })
})

function toggleAppointment(id) {
  $(`.app-row-${id}`).toggle();
}

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

function getClient(id) {
  $.get("/clients/" + id + ".json", function(data) {
    const client = new Client(data.id, data.name, data.email, data.phone, data.age, data.weight,
    data.goal, data.appointments[0].date, data.progress, data.notes);
    client.renderClientShow();
  })
}

function changeShowIdValues(id) {
  $('#previous').attr("data-id", id);
  $('#next').attr("data-id", id);
  $('#edit-client').attr("href", "/clients/" + id + "/edit");
  $('#remove-client').attr("href", "/clients/" + id);
  $('#note_client_id').attr("value", id);
  $('#clear-notes').attr("data-id", id);
}
