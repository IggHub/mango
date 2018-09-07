defmodule MangoWeb.Acceptance.OrderTest do
  use Mango.DataCase
  use Hound.Helpers
  alias Mango.Repo
  alias Mango.Catalog.Product

  hound_session()

  setup do
    alias Mango.CRM
    
    valid_attrs = %{
      "name" => "John",
      "email" => "john@example.com",
      "password" => "secret",
      "residence_area" => "Area 1",
      "phone" => "1111"
    }
    {:ok, _} = CRM.create_customer(valid_attrs)
    :ok
  end

  test "/orders page has historical orders" do
    navigate_to("/login")

    form = find_element(:id, "session-form")
    find_within_element(form, :name, "session[email]")
    |> fill_field("john@example.com")

    find_within_element(form, :name, "session[password]")
    |> fill_field("secret")

    find_within_element(form, :tag, "button")
    |> click

    ## THEN ##
    assert current_path() == "/"
    message = find_element(:class, "alert-info")
              |> visible_text()

    assert message == "Login successful"

    # Begin /orders test 
    navigate_to("/orders")

    # assert /orders page
    historical_order = find_element(:css, ".order-header") |> visible_text()
    assert historical_order == "Order History" 
  end
end
