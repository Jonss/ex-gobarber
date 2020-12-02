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

