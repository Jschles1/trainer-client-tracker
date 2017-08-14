class Appointment {
  constructor(id, user_id, client_id, date) {
    this.id = id
    this.user_id = user_id
    this.client_id = client_id
    this.date = date
  }
}

$(function() {
  $('a.load_appointments').on('click', function(e) {
    e.preventDefault()
    $('.index-list').html("")
    $('.index-header').html("Your Appointments:")
    $.get("/appointments.json", function(data) {
      var template = Handlebars.compile($('#appointments-index-template').html())
      var results = template(data)
      $('.index-list').append(results)
      console.log(data)
      // data.forEach(c => {
      //   console.log(c)
      // })
    })
  })
})