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

Client.prototype.indexName = function() {
  return `<a href="/clients/${this.id}">${this.name}</a>`
}

$(function() {
  $('a.load_clients').on('click', function(e) {
    e.preventDefault()
    $('.index-list').html("")
    $('.index-header').html("Your Clients:")
    $.get("/clients.json", function(data) {
      data.forEach(c => {
        const newClient = new Client(c.id, c.name, c.email, c.phone, c.age, c.weight,
        c.goal, c.completed_appointments, c.progress)
        $('.index-list').append(newClient.indexName())
      })
    })
  })
})

// function loadClients() {
//   $('.container').html("X")
//   console.log("This workds")
// }

// function loadAppointments() {
//   console.log("This works")
// }