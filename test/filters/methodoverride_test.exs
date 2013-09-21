defmodule Dynamo.Filters.MethodOverrideTest do
  defmodule MethodOverrideApp do
    use Dynamo.Router

    filter Dynamo.Filters.MethodOverride

    delete "/hello" do
      conn.send(200, "DELETED")
    end

    put "/hello" do
      conn.send(200, "PUT")
    end
  end

  use ExUnit.Case, async: true
  use Dynamo.HTTP.Case

  @endpoint MethodOverrideApp

  test "converts POST to DELETE when _method=DELETE param is specified" do
    conn = process @endpoint, :POST, "/hello?_method=DELETE"
    assert conn.status == 200
    assert conn.sent_body == "DELETED"
  end

  test "converts POST to PUT when _method=PUT param is specified" do
    conn = process @endpoint, :POST, "/hello?_method=PUT"
    assert conn.status == 200
    assert conn.sent_body == "PUT"
  end
end
