defmodule KeyValueWeb.GraphQlHelpers do
  import Phoenix.ConnTest
  import Plug.Conn

  # Required by the post function from Phoenix.ConnTest
  @endpoint KeyValueWeb.Endpoint

  def graphql_post(options, response \\ 200) do
    build_conn()
    |> put_resp_content_type("application/json")
    |> post("/graphql", options)
    |> json_response(response)
  end
end
