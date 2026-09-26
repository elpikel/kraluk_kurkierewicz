defmodule KralukKurkierewiczWeb.PageControllerTest do
  use KralukKurkierewiczWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, ~p"/")
    response = html_response(conn, 200)
    assert response =~ "Kraluk Kurkierewicz"
    assert response =~ "Pomoc prawna"
  end
end
