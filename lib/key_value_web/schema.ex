defmodule KeyValueWeb.Schema do
  alias KeyValueWeb.KeyValueResolver
  use Absinthe.Schema

  @moduledoc """
  GraphQL schema definition for key-value pairs.
  """
  object :key_value do
    field :key, :string
    field :value, :string
  end

  @doc """
  Defines GraphQL queries.
  """
  query do
    field :get_key, :key_value do
      arg :key, non_null(:string)
      resolve(&KeyValueResolver.get_key/3)
    end
  end

  @doc """
  Defines GraphQL mutations.
  """
  mutation do
    field :set_key, :key_value do
      arg :key, non_null(:string)
      arg :value, non_null(:string)
      resolve(&KeyValueResolver.set_key/3)
    end
  end
end
