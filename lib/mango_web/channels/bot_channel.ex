defmodule MangoWeb.BotChannel do
  use MangoWeb, :channel

  def join("pos", payload, socket) do
    welcome_text = "Hello! Welcome to Mango Point of Sale"
    {:ok, %{message: welcome_text}, socket}
  end

  def handle_in("status", payload, socket) do
    reply = %{ message: "You asked for status" }
    {:reply, {:ok, reply}, socket}
  end

  def handle_in(_, _payload, socket) do
    reply = %{ message: "I don't understand your question." }
    {:reply, {:error, reply}, socket}
  end

end
