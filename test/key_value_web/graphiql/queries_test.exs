defmodule KeyValueWeb.GraphiQl.QueriesTest do
  use ExUnit.Case
  use KeyValueWeb.GraphiQlCase

  alias KeyValue.RedisClient
  alias KeyValue.RedisModel

  setup do
    check_key = RedisClient.exist("key_test")
    unless check_key do
      :ok = RedisModel.set("key_test", "value_test")
    end
    :ok
  end

  describe "get_key - exist" do
    @get_key """
    query {
      getKey(key: "key_test") {
        key
        value
      }
    }
    """

    test "returns value when exist" do
      assert %{
               "data" => %{
                 "getKey" => %{
                   "key" => "key_test",
                   "value" => "value_test"
                 }
               }
             } ==
               graphiql_post(%{
                 query: @get_key
               })
    end
  end

  describe "get_key - not exist" do
    @get_key """
    query {
      getKey(key: "not_exist_key") {
        key
        value
      }
    }
    """

    test "returns null when not exist" do
      expected_result = %{
        "data" => %{
          "getKey" => nil
        },
        "errors" => [%{"locations" => [%{"column" => 3, "line" => 2}], "message" => "Key not found", "path" => ["getKey"]}]
      }
      assert expected_result ==
               graphiql_post(%{
                 query: @get_key
               })
    end
  end
end
