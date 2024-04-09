defmodule KeyValueWeb.KeyValueResolver do
  alias KeyValue.RedisModel

  @moduledoc """
  Resolver module for handling GraphQL queries and mutations related to key-value pairs.
  """

  @doc """
  Retrieves the value for a given key.

  ## Parameters
    - `_root`: The root value (unused in this resolver).
    - `args`: A map containing the arguments passed to the resolver. It should contain the `:key` to be retrieved.
    - `_info`: Additional information about the GraphQL execution context (unused in this resolver).

  ## Returns
    - `{:ok, value}`: If the key is found, returns the corresponding value.
    - `{:error, reason}`: If an error occurs, returns the reason for the error.
  """
  def get_key(_root, args, _info) do
    RedisModel.get(args[:key])
  end

  @doc """
  Sets a key-value pair.

  ## Parameters
    - `_root`: The root value (unused in this resolver).
    - `params`: A map containing the key and value to be set. It should contain the `:key` and `:value` fields.
    - `_info`: Additional information about the GraphQL execution context (unused in this resolver).

  ## Returns
    - `{:ok, result}`: If the key-value pair is successfully set, returns the result.
    - `{:error, reason}`: If an error occurs, returns the reason for the error.
  """
  def set_key(_root, %{key: key, value: value}, _info) do
    RedisModel.set(key, value)
  end
end