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
  constructor(id, name, email, phone, age, weight, goal, appointment, progress) {
    this.id = id
    this.name = name
    this.email = email
    this.phone = phone
    this.age = age
    this.weight = weight
    this.goal = goal
    this.appointment = appointment
    this.progress = progress
  }
}

Client.prototype.clientIndexFormatter = function() {
  return `
    <tr>
      <td><a href="/clients/${this.id}">${this.name}</a></td>
      <td><button class="btn btn-default" data-id="${this.id}" onClick="toggleAppointment(${this.id})">Show Next Appointment:</button></td>
    </tr>
    <tr class="app-row-${this.id}">
      <td>${moment(this.appointment).format('LLL')}</td>
      <td></td>
    </tr>
  `
}

$(function() {
  $('.most').hide()
  $('a.load_clients').on('click', function(e) {
    e.preventDefault()
    $('.index-header').html("Your Clients:")
    $('.most').show()
    $('.index-list').html(tableHeader)
    $.get("/clients.json", function(data) {
      data.forEach(c => {
        const newClient = new Client(c.id, c.name, c.email, c.phone, c.age, c.weight,
        c.goal, c.appointments[0].date, c.progress)
        $('tbody').append(newClient.clientIndexFormatter())
        $(`.app-row-${newClient.id}`).hide()
      })
    })
  })

 
  $('#note-form').on('submit', function(e) {
    e.preventDefault()
    var action = $(this).attr("action");
    var params = $(this).serialize();
    $.post(action, params)
      .done(function(response) {
        $('#ajax_submit').attr("disabled", false)
        var note = `<li>${response["text"]}</li>`
        $('.notes-list').append(note)
      })
  })

  $('#clear-notes').on('click', function() {
    var clientId = this.dataset.id
    $.ajax({
      url: '/notes',
      type: 'DELETE',
      data: {
        client_id: clientId
      },
      success: function() {
        $('.notes-list').empty()
      }
    })
  })

  $('.btn.btn-secondary.btn-sm').on('click', function() {
    var action = this.id
    var clientId =  parseInt(this.dataset.id)
    var idArray = []
    $.get('/clients.json', function(data) {
      data.forEach(c => {
        idArray.push(c.id)
      })
      if (action === "next") {
        getNext(clientId, idArray)
      } else {
        getPrevious(clientId, idArray)
      }
    })
  })
  
})

function toggleAppointment(id) {
  $(`.app-row-${id}`).toggle()
}

function getNext(id, array) {
  var next = id + 1
  while (next <= array[array.length - 1]) {
    if (array.includes(next)) {
      renderClient(next)
      break;
    } else {
      ++next
    }
  }
}

function getPrevious(id, array) {
  var descArray = array.reverse()
  var prev = id - 1
  while (prev >= descArray[descArray.length - 1]) {
    if (descArray.includes(prev)) {
      renderClient(prev)
      break;
    } else {
      --prev
    }
  }
}

function renderClient(id) {
  $.get("/clients/" + id + ".json", function(data) {
    $('#previous').attr("data-id", id)
    $('#next').attr("data-id", id)
    $('#edit-client').attr("href", "/clients/" + id + "/edit")
    $('#remove-client').attr("href", "/clients/" + id)
    $('#note_client_id').attr("value", id)
    $('#clear-notes').attr("data-id", id)

    $('#client-name').html(data["name"])
    $('#email').html(`Email: ${data["email"]}`)
    $('#phone').html(`Phone: ${data["phone"]}`)
    $('#age').html(`Age: ${data["age"]}`)
    $('#weight').html(`Current Weight: ${data["weight"]}`)
    $('#goal').html(`Goal: ${data["goal"]}`)
    $('.note-header').html(`Add a Note For ${data["name"]}:`)
    
    if (data["goal"] === "Lose Weight") {
      $('#progress').html(`Progress: ${data["progress"]} lbs. Lost`)
    } else {
      $('#progress').html(`Progress: ${data["progress"]} lbs. Gained`)
    }

    $('.notes-list').empty()
    data.notes.forEach(n => {
      $('.notes-list').append(`<li>${[n.text]}</li>`)
    })
  })
}