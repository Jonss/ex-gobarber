defmodule GobarberWeb.Auth.Guardian do
  use Guardian, otp_app: :gobarber

  alias Gobarber.User

  def subject_for_token(user, _claims) do
    IO.inspect(user)
    sub = to_string(user.email)
    {:ok, sub}
  end

  def resource_from_claims(claims) do
    claims
    |> Map.get("sub")
    |> Gobarber.fetch_user_by_email()
  end

  def authenticate(param) do
    %{"email" => email, "password" => password} = param

    case Gobarber.fetch_user_by_email(email) do
      nil -> {:error, :not_found}
      user -> validate_password(user, password)
    end
  end

  defp validate_password(%User{password_hash: hash} = user, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(user)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, token}
  end

end
