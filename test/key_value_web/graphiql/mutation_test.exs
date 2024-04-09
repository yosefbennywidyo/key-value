defmodule KeyValueWeb.GraphiQl.MutationsTest do
	use ExUnit.Case
  use KeyValueWeb.GraphiQlCase

  alias KeyValue.RedisClient
  alias KeyValue.RedisModel

  describe "set_key - success" do
    @set_key """
    mutation SetKeyValue {
		  setKey(key: "actual_key_test", value: "actual_value") {
		    key
		    value
		  }
		}
    """

    setup do
	  	check_key = RedisClient.exist("actual_key_test")
	  	if check_key do
	  		:ok = RedisClient.delete("actual_key_test")
	  		:ok
	  	else
	  		:ok
	  	end
	  end

    test "creates key value" do
      assert %{
               "data" => %{
                 "setKey" => %{
                   "key" => "actual_key_test",
                   "value" => "actual_value"
                 }
               }
             } =
               graphiql_post(%{
                 query: @set_key
               })
    end
  end

  describe "set_key - error" do
    @set_key """
    mutation SetKeyValue {
		  setKey(key: "actual_key_test", value: "actual_value") {
		    key
		    value
		  }
		}
    """

    setup do
	  	check_key = RedisClient.exist("actual_key_test")
	  	if check_key do
	  		:ok
	  	else
	  		:ok = RedisModel.set("actual_key_test", "actual_value")
	  		:ok
	  	end
	  end

    test "returns error when key is exist" do
      assert %{
               "data" => %{"setKey" => nil},
               "errors" => [
                 %{
                   "message" => "Key already exists",
                   "path" => ["setKey"],
                   "locations" => [%{"column" => 1, "line" => 2}]
                 }
               ]
             } =
               graphiql_post(%{
                 query: @set_key
               })
    end
  end
end