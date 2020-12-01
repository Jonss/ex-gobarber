defmodule GobarberWeb.Auth.Guardian do
  use Guardian, otp_app: :gobarber

  alias Gobarber.User

  def subject_for_token(user, _claims) do
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

    Gobarber.fetch_user_by_email(email)
    |> validate_password(password)
  end

  defp validate_password({:error, _nil}, _password), do: {:error, :not_found}

  defp validate_password({:ok, %User{password_hash: hash} = user}, password) do
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
