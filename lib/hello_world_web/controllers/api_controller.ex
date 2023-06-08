defmodule HelloWorldWeb.ApiController do
  use HelloWorldWeb, :controller

  def index(conn, _params) do
    message = %{message: "Hello, world!"}

    conn
    |> put_status(:ok)
    |> json(message)
  end
end
