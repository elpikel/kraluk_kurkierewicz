defmodule KralukKurkierewiczWeb.PageController do
  use KralukKurkierewiczWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
