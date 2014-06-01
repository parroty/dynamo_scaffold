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
    conn = conn.assign(:weather, %Weather{})
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
    params = conn.params[:weather] |> parse_weather
    Map.merge(%Weather{}, params) |> Repo.insert
    redirect conn, to: "/"
  end

  @doc "update"
  put "/:id" do
    params  = conn.params[:weather] |> parse_weather
    weather = Repo.get(Weather, get_id(conn.params))
    Map.merge(weather, params) |> Repo.update
    redirect conn, to: "/"
  end

  @doc "destroy"
  delete "/:id" do
    Repo.get(Weather, get_id(conn.params)) |> Repo.delete
    redirect conn, to: "/"
  end

  defp get_id(param) do
    param[:id] |> binary_to_integer
  end

  defp parse_weather(param) do
    %{
      city:    param[:city],
      temp_lo: param[:temp_lo] |> String.strip |> to_integer,
      temp_hi: param[:temp_hi] |> String.strip |> to_integer,
      prcp:    param[:prcp]    |> String.strip |> to_float
    }
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
