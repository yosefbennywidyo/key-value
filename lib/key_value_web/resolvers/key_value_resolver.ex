defmodule KeyValueWeb.KeyValueResolver do
  alias KeyValue.RedisModel

  def get_key(_root, args, _info) do
    RedisModel.get(args[:key])
  end

  def set_key(_root, %{key: key, value: value}, _info) do
    RedisModel.set(key, value)
  end
end