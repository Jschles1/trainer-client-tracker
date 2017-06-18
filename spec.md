# Specifications for the Rails Assessment

Specs:
- [x] Using Ruby on Rails for the project
- [x] Include at least one has_many relationship (x has_many y e.g. User has_many Recipes)
  - User has_many appointments, Client has_many appointments.

- [x] Include at least one belongs_to relationship (x belongs_to y e.g. Post belongs_to User)
  - Appointments belong_to both a client and a user.

- [x] Include at least one has_many through relationship (x has_many y through z e.g. Recipe has_many Items through Ingredients)
  - Users have many clients through appointments, clients have many users through appointments.

- [x] The "through" part of the has_many through includes at least one user submittable attribute (attribute_name e.g. ingredients.quantity)
  - Appointments have a date.

- [x] Include reasonable validations for simple model objects (list of model objects with validations e.g. User, Recipe, Ingredient, Item)
  - See validations in each model, as well as custom email and phone number validators.

- [x] Include a class level ActiveRecord scope method (model object & class method name and URL to see the working feature e.g. User.most_recipes URL: /users/most_recipes)
  - Client.most_progress and Client.most_dedicated.

- [x] Include a nested form writing to an associated model using a custom attribute writer (form URL, model name e.g. /recipe/new, Item)
  - Client forms have a nested form for appointments, using the appointments_attributes= custom writer.

- [x] Include signup (how e.g. Devise)
  - 1. User clicks on "Sign Up" link on the navbar, which sends a GET request to the '/signup' route, which then
       executes the new action in the Users controller. The '/users/new' view is then rendered.

    2. '/users/new' contains a form where the user enters their username, email, and password. Submitting the form
        sends a POST request to the '/users' route, which then executes the create action in the Users
        controller.

    3. In the create action, a new User object is created with the params hash provided by the form (using the
       user_params method). If the newly created User object is able to be successfully saved to the database
       without raising any validation errors, the session[:user_id] is set equal to the newly created user's id, and is then redirected to the '/clients' route (or client index). If not, the '/users/new' template is rendered along with the errors regarding the validations that failed.

- [x] Include login (how e.g. Devise)
  - 1. User clicks on "Log In" link on the navbar, which sends a GET request to the '/login' route, which then
       executes the new action in the Sessions controller. The '/sessions/new' view is then rendered.

    2. '/sessions/new' contains a form where the user enters their email and password. Submitting the form sends
        a POST request to the '/sessions' route, which then executes the create action in the Sessions controller.

    3. In the create action, the normal_login method is executed (since OmniAuth is not being used). The
       normal_login first searches the database for a User object that has an email matching email contained in
       the params hash provided by the form, and stores the User object in the instance variable @user. If !!@user
       returns true (meaning the User containing the email matching the email provided in the params hash exists),
       and if the password provided in the params hash matches the password_digest of the User, the session[:user_id] is set equal to the @user's id. The user is then redirected to the '/clients' route (or
       client index). If either of the previous conditions return false, the user is redirected to the login page,
       with a flash alert saying the the login failed.

- [x] Include logout (how e.g. Devise)
  - 1. User clicks on "Log Out" link on the navbar, which sends a GET request to the '/logout' route, which then
       executes the destroy action in the Sessions controller. The session[:user_id] is deleted, and the user is redirected to the login page.

- [x] Include third party signup/login (how e.g. Devise/OmniAuth)
  - Uses OmniAuth to allow users to log in through Facebook.

- [x] Include nested resource show or index (URL e.g. users/2/recipes)
  - Nested resource for appointments index (users/:user_id/appointments).

- [x] Include nested resource "new" form (URL e.g. recipes/1/ingredients)
  - Nested resource for new clients form (users/:user_id/clients/new).

- [x] Include form display of validation errors (form URL e.g. /recipes/new)
  - See 'layouts/errors' view partial.

Confirm:
- [x] The application is pretty DRY
- [x] Limited logic in controllers
- [x] Views use helper methods if appropriate
- [x] Views use partials if appropriate
