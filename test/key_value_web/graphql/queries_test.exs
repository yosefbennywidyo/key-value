defmodule KeyValueWeb.GraphQl.QueriesTest do
	use ExUnit.Case
  use KeyValueWeb.GraphQlCase

  alias KeyValue.RedisClient
  alias KeyValue.RedisModel

  setup do
  	check_key = RedisClient.exist("key_test")
  	if check_key do
  		:ok
  	else
  		:ok = RedisModel.set("key_test", "value_test")
  		:ok
  	end
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

    test "returns value when found" do
      assert %{
               "data" => %{
                 "getKey" => %{
                   "key" => "key_test",
                   "value" => "value_test"
                 }
               }
             } ==
               graphql_post(%{
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

    test "returns null when not found" do
      assert %{
               "data" => %{
                 "getKey" => nil
               },
               "errors" => [%{"locations" => [%{"column" => 3, "line" => 2}], "message" => "Key not found", "path" => ["getKey"]}]
             } ==
               graphql_post(%{
                 query: @get_key
               })
    end
  end
end
