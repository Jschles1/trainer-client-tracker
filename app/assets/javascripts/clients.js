$(function() {
    attachListeners();
})

function attachListeners() {
    $('#new-client').on('click', function(e) {
        e.preventDefault()
        console.log("This worked")
    })
}