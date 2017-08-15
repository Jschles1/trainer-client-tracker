var tableHeader = `
  <table class="table">
    <tr class="header-row">
      <th class="column-header">Client:</th>
      <th class="column-header"></th>
    </tr>
  </table>
`

class Client {
  constructor(id, name, email, phone, age, weight, goal, completed_appointments, progress) {
    this.id = id
    this.name = name
    this.email = email
    this.phone = phone
    this.age = age
    this.weight = weight
    this.goal = goal
    this.completed_appointments = completed_appointments
    this.progress = progress
  }
}

Client.prototype.clientIndexFormatter = function() {
  return `
    <tr>
      <td><a href="/clients/${this.id}">${this.name}</a></td>
      <td><button class="btn btn-default" data-id="${this.id}">Show Notes</button></td>
    </tr>
    <tr class="show-row-${this.id}">
      <td>Test</td>
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
        c.goal, c.completed_appointments, c.progress)
        $('tbody').append(newClient.clientIndexFormatter())
        $(`.show-row-${newClient.id}`).hide()
        
        $('button').on('click', function() {
          toggleNotes(this.dataset.id)
        })
      })
    })
  })

  $('#note-form').on('submit', function(e) {
    e.preventDefault()
  })
})

function toggleNotes(id) {
  $(`.show-row-${id}`).toggle()
}