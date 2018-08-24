defmodule Mango.Sales.Order do
  use Ecto.Schema
  import Ecto.Changeset
  alias Mango.Sales.{Order, LineItem}

  schema "orders" do
    embeds_many :line_items, LineItem, on_replace: :delete
    field :status, :string
    field :total, :decimal

    timestamps()
  end

  @doc false
  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :total, :line_items])
    |> validate_required([:status, :total, :line_items])
  end
end
