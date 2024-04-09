defmodule KeyValueWeb.Schema do
  alias KeyValueWeb.KeyValueResolver
  use Absinthe.Schema

  object :key_value do
    field :key, :string
    field :value, :string
  end

  query do
    field :get_key, :key_value do
      arg :key, non_null(:string)
      resolve(&KeyValueResolver.get_key/3)
    end
  end

  mutation do
    field :set_key, :key_value do
      arg :key, non_null(:string)
      arg :value, non_null(:string)
      resolve(&KeyValueResolver.set_key/3)
    end
  end
end
