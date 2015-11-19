defmodule Backend.ApiController do
  use Backend.Web, :controller
  alias Backend.User
  import Ecto.Query

  def register(conn, %{"name" => name}) do
    changeset = User.changeset(
      %User{},
      %{
        "name" => name,
        "points" => 0,
      }
    )
    case Repo.insert(changeset) do
      {:ok, user} ->
        render(conn, "get_user.json", data: user)
      _ -> ;
    end
  end

  def get_user(conn, %{"id" => id}) do
    user = Repo.get!(User, id)
    render(conn, "get_user.json", data: user)
  end

  def update_score(conn, %{"id" => id, "new_score" => new_score}) do
    user = Repo.get!(User, id)
    {int_score, _} = Integer.parse(new_score)
    case (user.points <= int_score) do
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
