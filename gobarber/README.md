# Gobarber

## How to test?

* Execute `make env-test`
* Then execute `mix test`

### To execute a specific test file:

* Execute `mix test test/PATH-OF-TEST`. Ex.: `mix test test/gobarber/user/create_test.exs`

### To run a spefic test:

* Execute `mix test test/PATH-OF-TEST:line_number_in_file` . Ex.: `mix test test/gobarber/user/create_test.exs:7`

## How to run the app?

* First of all, create a file called .env.dev. At the moment, this is the structure:
```
export AUTH_SECRET=smth_here
```
* Execute `make env-up` |> `source .env.dev`
* Then execute `mix ecto.setup` |> `mix phx.server` |> Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.


# TODO
### [ ] - Password recover
**FR - Functional requirements** 
    - [ ] - As user, I want to recover my password
    - [ ] - As user, I want to receive an email with instructions to reset my password
    - [ ] - A user, I want to reset my password

**NFR - Not functional requirements**
    - [ ] - Use mailtrap to test in dev env
    - [ ] - Use Amazon SES to send in production
    - [ ] - Send email must be async

**Business rules**
    - [ ] - The link sent to recover password must expire in 2 hours
    - [ ] - User must confirm the password

### [ ] - Update profile
**FR - Functional requirements** 
    - [ ] - User must be able to update his profile. Name, email and password
**NFR - Not functional requirements**
**Business rules**
    - [ ] - User can't update his email to a existing email
    - [ ] - To update password, the user must send his old password and confirm this new password

### [ ] - Create provider panel
**FR - Functional requirements** 
    - [ ] - A provider can get a list of his appointments by each day
    - [ ] - A provider must receive a notification every time an appoitment is scheduled
    - [ ] - A provider must view unread notifications

**NFR - Not functional requirements**
    - [ ] - The provider list must have cache
    - [ ] - Notifications must be persisted on MongoDB
**Business rules**
    - [ ] - The notification must have a status, read or unread
### [ ] - Appointment scheduling
**FR - Functional requirements** 
    - [ ] - A customer must be able to list all providers
    - [ ] - After select a provider, a user can get a list of business days with available appointment of a specific provider
    - [ ] - User can get a list of free time of a specific provider
    - [ ] - User must be able to create a new appointment with a provider
**NFR - Not functional requirements**
    - [ ] - The provider list must be persisted in cache
**Business rules**
    - [ ] - Each appoint must last 1 hour
    - [ ] - The appointment range is between 8am until 18pm (first at 8 am, last at 17h)
    - [ ] - A user can't schedule to a busy appoitment
    - [ ] - A user can't schedule an appointment in the past
    - [ ] - A user can' schedule an appoint with oneself