defmodule Backend.ApiView do
  use Backend.Web, :view
  @attributes [:id, :name, :points]

  def render("get_user.json", %{data: data}) do
    data |> Map.take(@attributes)
  end

  def render("ranking.json", %{data: data}) do
    data
    |> Enum.map(fn x -> Map.take(x, @attributes) end)
  end
end
