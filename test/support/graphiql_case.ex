defmodule KeyValueWeb.GraphiQlCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use KeyValueWeb.ConnCase

      import KeyValueWeb.GraphiQlHelpers
    end
  end
end