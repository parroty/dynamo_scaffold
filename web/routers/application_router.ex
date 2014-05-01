defmodule ApplicationRouter do
  use Dynamo.Router
  filter Dynamo.Filters.MethodOverride

  prepare do
    conn = conn.fetch([:cookies, :params])
    conn.assign :layout, "main"
  end

  @doc "index"
  get "/" do
    conn = conn.assign(:items, Repo.all(Weather))
    render conn, "index.html"
  end

  @doc "new"
  get "/new" do
    conn = conn.assign(:weather, Weather.new)
    render conn, "new.html"
  end

  @doc "show"
  get "/:id" do
    conn = conn.assign(:weather, Repo.get(Weather, get_id(conn.params)))
    render conn, "show.html"
  end

  @doc "edit"
  get "/:id/edit" do
    conn = conn.assign(:weather, Repo.get(Weather, get_id(conn.params)))
    render conn, "edit.html"
  end

  @doc "create"
  post "/" do
    params = Dict.get(conn.params, :weather) |> parse_weather
    Weather.new(params) |> Repo.insert
    redirect conn, to: "/"
  end

  @doc "update"
  put "/:id" do
    params  = Dict.get(conn.params, :weather) |> parse_weather
    weather = Repo.get(Weather, get_id(conn.params))
    weather.update(params) |> Repo.update
    redirect conn, to: "/"
  end

  @doc "destroy"
  delete "/:id" do
    Repo.get(Weather, get_id(conn.params)) |> Repo.delete
    redirect conn, to: "/"
  end

  defp get_id(param) do
    Dict.get(param, :id) |> binary_to_integer
  end

  defp parse_weather(param) do
    [
      city:    Dict.get(param, :city),
      temp_lo: Dict.get(param, :temp_lo) |> String.strip |> to_integer,
      temp_hi: Dict.get(param, :temp_hi) |> String.strip |> to_integer,
      prcp:    Dict.get(param, :prcp)    |> String.strip |> to_float
    ]
  end

  defp to_integer(binary) do
    case Integer.parse(binary) do
      {integer, _binary} -> integer
      _ -> 0
    end
  end

  defp to_float(binary) do
    case Float.parse(binary) do
      {float, _binary} -> float
      _ -> 0.0
    end
  end
end
