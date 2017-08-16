var tableHeader = `
  <table class="table">
    <tr class="header-row">
      <th class="column-header">Client:</th>
      <th class="column-header"></th>
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
      <td><button class="btn btn-default" data-id="${this.id}">Show Next Appointment:</button></td>
    </tr>
    <tr class="app-row-${this.id}">
      <td>${moment(this.appointment).format('LLL')}</td>
      <td></td>
    </tr>
  `
}

$(function() {
  $('a.load_clients').on('click', function(e) {
    e.preventDefault()
    $('.index-header').html("Your Clients:")
    
    $('.index-list').html(tableHeader)
    $.get("/clients.json", function(data) {
      data.forEach(c => {
        const newClient = new Client(c.id, c.name, c.email, c.phone, c.age, c.weight,
        c.goal, c.appointments[0].date, c.progress)
        $('tbody').append(newClient.clientIndexFormatter())
        $(`.app-row-${newClient.id}`).hide()
        
        $('button').on('click', function() {
          toggleAppointment(this.dataset.id)
        })
      })
    })
  })

  $('#note-form').on('submit', function(e) {
    e.preventDefault()
    var action = $(this).attr("action");
    var params = $(this).serialize();
    $.post(action, params)
      .done(function(response) {
        var note = `<li>${response["text"]}</li>`
        $('.notes-list').append(note)
      })
  })
})

function toggleAppointment(id) {
  $(`.app-row-${id}`).toggle()
}