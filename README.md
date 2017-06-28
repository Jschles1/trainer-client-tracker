## Trainer Client Tracker

### Introduction

This app allows personal trainers to keep a list of their clients and track their progress, as well as keep track of appointments.

### Usage

clone this repo and install the needed gems:

```
$ bundle install
```

Next, migrate the database:

```
$ rails db:migrate
```

Now run the app using:

```
$ rails server
```

### Instructions

To create an account, click "Sign Up", fill out the appropriate fields, then click "Submit". Alternatively, You can sign in using your Facebook account by clicking "Sign In w/ Facebook".

Once signed in, you can add to your list of clients by clicking "Create Client" on the "My Clients" page, where you fill out your new client's stats and schedule your first appointment with them.

Clicking on a client's name once created will bring you to that individual client's show page, where you can choose to either edit that client's stats by clicking "Edit Client", or remove the client from your client list by clicking "Remove Client".

You can access your list of appointments that you have by clicking on "My Appointments". Clicking on "Reschedule Appointment" will allow you to edit the time of the particular appointment.

When you meet and train with your client at the time of an appointment, click the "Appointment Complete" button. For your first appointment with a client, you will simply be asked to schedule the next appointment. For each appointment you complete with this client after the first one, you will be asked how much weight they gained or lost since the last appointment (based on whether their goal was to lose or gain weight). You can view how much progress a client has made toward their goal on their show page.

On the "My Clients" page, your client that has made the most progress towards their goal will be displayed next to "Client With Most Progress Made:". Your client that has showed up for the most appointments will be displayed next to "Client With Most Dedication:"

## Contributing

Bug reports and pull requests are welcome on GitHub at [this project's repository][trainer-client-tracker]. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

This Web Application is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
