defmodule Backend.PageControllerTest do
  use Backend.ConnCase

  test "GET /" do
    conn = get conn(), "/"
    assert html_response(conn, 200) =~ "Break-Kraut.swf"
  end
end
