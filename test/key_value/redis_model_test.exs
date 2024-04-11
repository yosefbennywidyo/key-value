defmodule KeyValue.RedisModelTest do
	require IEx
  use ExUnit.Case

  alias KeyValue.RedisClient
  alias KeyValue.RedisModel

  describe "set/2" do
    test "sets a key-value pair in Redis" do
    	check_key = RedisClient.exist("test_key")
    	if check_key do
		  	:ok = RedisClient.delete("test_key")
		  	:ok
		  else
		  	:ok
		  end

      {:ok, result} = RedisModel.set("test_key", "test_value")
      assert result == %{value: "test_value", key: "test_key"}
    end  

    test "returns an error when setting fails" do
    	check_key = RedisClient.exist("test_key")
    	if check_key do
		  	:ok
		  else
		  	{:ok, result} = RedisClient.set("test_key", "test_value")
		  	:ok
		  end

      {:error, reason} = RedisModel.set("test_key", "test_value")
      assert reason == "Key already exists"
    end
  end

  describe "get/1" do
    test "retrieves the value for a key from Redis" do
    	check_key = RedisClient.exist("test_key")
    	if check_key do
		  	{:ok, %{value: "test_value", key: "test_key"}}
		  else
		  	:ok = RedisClient.set("test_key", "test_value")
		  	:ok
		  end

      {:ok, result} = RedisModel.get("test_key")
      assert result == %{value: "test_value", key: "test_key"}
    end

    test "returns an error when key is not found" do
      {:error, reason} = RedisModel.get("nonexistent_key")
      assert reason == "Key not found"
    end
  end

  describe "transform_result/1" do
    test "transforms the retrieved value if needed" do
      result = RedisModel.transform_result(%{value: nil, key: "example_key"})
      assert result == %{value: nil, key: "example_key"}
    end

    test "does not transform the retrieved value if not needed" do
      result = RedisModel.transform_result(%{value: "existing_value", key: "example_key"})
      assert result == %{value: "existing_value", key: "example_key"}
    end
  end
end
