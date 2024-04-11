defmodule KeyValue.RedisClient do
  require IEx

  @moduledoc """
  Low-level interaction with Redis.

  This module provides functions to establish connections and directly interact with Redis.

  For higher-level operations, see `KeyValue.Storage` module.
  """

  def is_redis_up?() do
    Process.flag(:trap_exit, true)
    case Redix.start_link("redis://#{System.fetch_env!("REDIS_HOST")}:#{System.fetch_env!("REDIS_PORT")}", sync_connect: true, name: :redix) do
      {:ok, _} -> true
      {:error, _} -> false
    end
  end
  
  @doc """
  Starts a connection to Redis if not already started.
  """
  def start_link do
    case Process.whereis(:redix) do
      nil ->
        case is_redis_up?() do
          true -> {:ok, Process.whereis(:redix)}
          false -> {:error, :redis_down}
        end

      pid ->
        {:ok, pid}
    end 
  end

  @doc """
  Checks if a key exists in Redis.

  Returns:
    - `true` if key exists.
    - `false` if key doesn't exist.
  """
  def exist(key) do
    case start_link() do
      {:ok, conn} ->
        case Redix.command(conn, ["EXISTS", key]) do
          {:ok, 1} -> true
          {:ok, 0} -> false
        end
    end
  end

  @doc """
  Sets a key-value pair in Redis.

  Returns:
    - `{:ok, %{key: key, value: value}}` if successful.
    - `{:error, reason}` if an error occurs.
  """
  def set(key, value) do
    case start_link() do
      {:ok, conn} ->
        case exist(key) do
          true -> {:error, "Key already exists"}
          false ->
            case Redix.command(conn, ["SET", key, value]) do
              {:ok, "OK"} -> {:ok, %{key: key, value: value}}
            end
          other -> {:error, "Unexpected response from Redis EXISTS command: #{inspect(other)}"}
        end
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Retrieves the value for a given key from Redis.

  Returns:
    - `{:ok, %{key: key, value: value}}` if key exists.
    - `{:error, :not_found}` if key doesn't exist.
    - `{:error, reason}` if an error occurs.
  """
  def get(key) do
    case start_link() do
      {:ok, conn} ->
        case Redix.command(conn, ["GET", key]) do
          {:ok, result} ->
            if result == nil do
              {:error, :not_found}
            else
              {:ok, %{key: key, value: result}}
            end
        end
      {:error, reason} -> {:error, reason}
    end
  end

  @doc """
  Deletes a key from Redis.

  Returns:
    - `:ok` if successful.
    - `{:error, reason}` if an error occurs.
  """
  def delete(key) do
    case start_link() do
      {:ok, conn} ->
        case exist(key) do
          true ->
            case Redix.command(conn, ["DEL", key]) do
              {:ok, _} -> :ok
            end
          false -> :ok  # Key doesn't exist, so deletion is considered successful
        end
    end
  end
end

