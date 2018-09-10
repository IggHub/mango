defmodule MangoWeb.Admin.OrderController do 
  use MangoWeb, :controller

  alias Mango.Sales

  def index(conn, _params) do
    orders = Sales.list_orders
    conn
    |> render("index.html", orders: orders)
  end

  def show(conn, %{"id" => id}) do
    order = Sales.get_order!(id)
    conn
    |> render("show.html", order: order)
  end
end
