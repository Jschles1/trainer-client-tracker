# Specifications for the Rails with jQuery Assessment

Specs:
- [x] Use jQuery for implementing new requirements
- [x] Include a show resource rendered using jQuery and an Active Model Serialization JSON backend.
  - On a client's show page, clicking either the "Next" or "Previous" buttons will render a new client
    resource to the page without a page refresh.
- [x] Include an index resource rendered using jQuery and an Active Model Serialization JSON backend.
  - On the dashboard, clicking either the "My Clients" or "My Appointments" link on the navbar will render
    the respective index resource to the page in a table format.
- [x] Include at least one has_many relationship in information rendered via JSON and appended to the DOM.
  - When the client index resource is rendered to the page, each client's associated appointment object is also
    rendered. The user can click the "Show Next Appointment:" button to toggle the appearance of the client's
    appointment's date to the page.
- [x] Use your Rails API and a form to create a resource and render the response without a page refresh.
  - On the client show page, the user can dynamically create a note object for that client and render it to the
    page without a page refresh.
- [x] Translate JSON responses into js model objects.
- [x] At least one of the js model objects must have at least one method added by your code to the prototype.
  - renderClientShow() and clientIndexFormatter() are methods that belong to the Client prototype.
    formatRow() is a method that belongs to the Appointment prototype.

Confirm
- [x] You have a large number of small Git commits
- [x] Your commit messages are meaningful
- [x] You made the changes in a commit that relate to the commit message
- [x] You don't include changes in a commit that aren't related to the commit message
