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

$(function() {
  $('a.load_clients').on('click', function(e) {
    e.preventDefault()
    $('.container').html("")
    $.get("/clients.json", function(data) {
      console.log(data)
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