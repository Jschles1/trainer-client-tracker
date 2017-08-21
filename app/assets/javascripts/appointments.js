var tableHeader = `
  <table class="table">
    <tr class="header-row">
      <th class="column-header">Client:</th>
      <th class="column-header">Date:</th>
      <th class="column-header"></th>
      <th class="column-header"></th>
    </tr>
  </table>
`

function Appointment(id, user_id, client_id, client_name, date) {
  this.id = id
  this.user_id = user_id
  this.client_id = client_id
  this.client_name = client_name
  this.date = date
}

Appointment.prototype.formatRow = function() {
  return `
    <tr>
      <td>${this.client_name}</td>
      <td>${moment(this.date).format('LLL')}</td>
      <td><a href="/clients/${this.client_id}/appointments/${this.id}/edit" class="btn btn-default">Reschedule Appointment</a></td>
      <td><a href="/clients/${this.client_id}/appointment_complete" class="btn btn-success">Appointment Complete</a></td>
    </tr>
  `
}

$(function() {
  $('a.load_appointments').on('click', function(e) {
    e.preventDefault();
    $('.most').hide();
    $('.index-header').html("Your Appointments:");
    $('.index-list').html(tableHeader);
    $.get("/appointments.json", function(data) {
      data.forEach(a => {
        const newAppointment = new Appointment(a.id, a.user_id, a.client_id, a.client.name, a.date);
        $('tbody').append(newAppointment.formatRow());
      })
    })
  })
})