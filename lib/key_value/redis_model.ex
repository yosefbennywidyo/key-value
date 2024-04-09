defmodule KeyValue.RedisModel do
	require IEx
  @moduledoc """
  Interface for interacting with data stored in Redis.
  """
  
  # Function to set a key-value pair in Redis
  def set(key, value) do
    case KeyValue.RedisClient.set(key, value) do
    	{:ok, result} -> {:ok, result}
      {:error, :not_found} -> {:error, "Key not found"}
      {:error, "Key already exists"} -> {:error, "Key already exists"}
    end
  end

  # Function to retrieve the value for a key from Redis
  def get(key) do
    case KeyValue.RedisClient.get(key) do
      {:ok, result} -> {:ok, result}
      {:error, :not_found} -> {:error, "Key not found"}
      {:error, reason} -> {:error, reason}
    end
  end

  # Function to transform the retrieved value if needed
  def transform_result(%{value: nil} = result), do: result
  def transform_result(value), do: value
end
