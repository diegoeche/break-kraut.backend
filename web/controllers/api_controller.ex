defmodule Backend.ApiController do
  use Backend.Web, :controller
  alias Backend.User
  import Ecto.Query

  def get_user(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "get_user.json", data: user)
  end

  def update_score(conn, %{"id" => id, "new_score" => new_score}) do
    user = Repo.get!(User, id)
    case (user.points <= new_score) do
      true ->
        {:ok, user} = Repo.update(User.changeset(user, %{:points => new_score}))
      _ -> ;
    end
    render(conn, "get_user.json", data: user)
  end

  def ranking(conn, _params) do
    # Macro magic from ecto
    ranking =
      User
      |> limit([u], 10)
      |> order_by([u], desc: u.points)
      |> Repo.all
    render(conn, "ranking.json", data: ranking)
  end
end
