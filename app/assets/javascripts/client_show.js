$(function() {
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