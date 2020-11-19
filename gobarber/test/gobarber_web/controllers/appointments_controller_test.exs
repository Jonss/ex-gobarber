defmodule GobarberWeb.AppointmentsControllerTest do
  use GobarberWeb.ConnCase

  alias Gobarber.Appointment

  describe "create/2" do
    setup %{conn: conn} do
      {:ok, conn: conn}
    end

    test "when params is valid should return an appointment", %{conn: conn} do
      params = %{provider: "Jupiter Stein", date: "2020-11-18 16:00:00"}

      response =
        conn
        |> post(Routes.appointments_path(conn, :create, params))
        |> json_response(:created)

      assert %{"id" => _id, "date" => "2020-11-18T16:00:00Z", "provider" => "Jupiter Stein"} =
               response
    end

    test "when provider is empty, should return 400 status code", %{conn: conn} do
      params = %{provider: "", date: "2020-11-18 16:00:00"}

      response =
        conn
        |> post(Routes.appointments_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"provider" => ["can't be blank"]}} == response
    end

    test "when date is invalid, should return 400 status code", %{conn: conn} do
      params = %{provider: "Jupiter Stein", date: "2020-11-18"}

      response =
        conn
        |> post(Routes.appointments_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"date" => ["is invalid"]}} == response
    end

    test "when date and provider are empty, should return 400 status code", %{conn: conn} do
      params = %{provider: "", date: ""}

      response =
        conn
        |> post(Routes.appointments_path(conn, :create, params))
        |> json_response(:bad_request)

      assert %{"message" => %{"date" => ["can't be blank"], "provider" => ["can't be blank"]}} ==
               response
    end

    test "when appointment is already booked, should return an unprocessable tuple", %{conn: conn} do
      params = %{provider: "Jupiter Stein", date: "2020-11-18 16:00:00"}

      conn
      |> post(Routes.appointments_path(conn, :create, params))
      |> json_response(:created)

      response =
        conn
        |> post(Routes.appointments_path(conn, :create, params))
        |> json_response(422)

      assert %{"message" => "provider Jupiter Stein is already booked at 2020-11-18 16:00:00Z"} == response

    end

  end
end
