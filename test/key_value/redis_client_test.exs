defmodule KeyValue.RedisClientTest do
	require IEx
  use ExUnit.Case

  alias KeyValue.RedisClient

  setup do
    # Ensure a clean Redis state before each test
    :ok = RedisClient.delete("test_key")
    :ok
  end

  test "start_link establishes connection to Redis" do
    assert {:ok, _} = RedisClient.start_link()
  end

  test "exist returns true if key exists" do
    {:ok, result} = RedisClient.set("test_key", "test_value")
    assert RedisClient.exist("test_key") == true
  end

  test "exist returns false if key doesn't exist" do
    assert RedisClient.exist("non_existing_key") == false
  end

  test "set adds a key-value pair to Redis" do
    assert {:ok, %{key: "test_key", value: "test_value"}} = RedisClient.set("test_key", "test_value")
  end

  test "set returns error if key already exists" do
    {:ok, result }= RedisClient.set("test_key", "test_value")
    assert {:error, "Key already exists"} = RedisClient.set("test_key", "new_value")
  end

  test "get retrieves the value for a key from Redis" do
    {:ok, result } = RedisClient.set("test_key", "test_value")
    assert {:ok, %{key: "test_key", value: "test_value"}} = RedisClient.get("test_key")
  end

  test "get returns :not_found if key doesn't exist" do
    assert {:error, :not_found} = RedisClient.get("non_existing_key")
  end

  test "delete removes a key from Redis" do
    {:ok, result} = RedisClient.set("test_key", "test_value")
  	assert :ok = RedisClient.delete("test_key")
  	assert RedisClient.exist("test_key") == false
  end

  test "delete returns :ok if key doesn't exist" do
    assert :ok = RedisClient.delete("non_existing_key")
  end
end
