defmodule KeyValueWeb.GraphQlCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use KeyValueWeb.ConnCase

      import KeyValueWeb.GraphQlHelpers
    end
  end
end