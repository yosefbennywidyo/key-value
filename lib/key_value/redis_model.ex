defmodule KeyValue.RedisModel do
	require IEx
  @moduledoc """
  Interface for interacting with data stored in Redis.
  """
  
  @doc """
  Function to set a key-value pair in Redis.
  """
  def set(key, value) do
    case KeyValue.RedisClient.set(key, value) do
    	{:ok, result} -> {:ok, result}
      {:error, :redis_down} -> {:error, "Redis server is down"}
      {:error, "Key already exists"} -> {:error, "Key already exists"}
    end
  end

  @doc """
  Function to retrieve the value for a key from Redis.
  """
  def get(key) do
    case KeyValue.RedisClient.get(key) do
      {:ok, result} -> {:ok, result}
      {:error, :not_found} -> {:error, "Key not found"}
      {:error, :redis_down} -> {:error, "Redis server is down"}
    end
  end

  @doc """
  Function to transform the retrieved value if needed.
  """
  def transform_result(%{value: nil} = result), do: result
  def transform_result(value), do: value
end
