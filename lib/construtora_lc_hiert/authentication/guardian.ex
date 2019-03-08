defmodule ConstrutoraLcHiert.Authentication.Guardian do
  use Guardian, otp_app: :construtora_lc_hiert

  alias ConstrutoraLcHiert.Accounts

  def subject_for_token(user, _claims) do
    {:ok, to_string(user.id)}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Accounts.get_user!(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
