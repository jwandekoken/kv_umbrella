defmodule KV.Bucket do
  use Agent, restart: :temporary

  @doc """
  Starts a new bucket.
  """
  def start_link(_opts) do
    Agent.start_link(fn -> %{} end)
  end

  @doc """
  Gets a value from the `bucket` by `key`.
  """
  def get(bucket, key) do
    # &Map.get(&1, key) is the same as
    # fn state -> Map.get(state, key) end
    Agent.get(bucket, &Map.get(&1, key))
  end

  @doc """
  Puts the `value` for the given `key` in the `bucket`.
  """
  def put(bucket, key, value) do
    # &Map.put(&1, key, value) is the same as
    # fn state -> Map.put(state, key, value) end
    Agent.update(bucket, &Map.put(&1, key, value))
  end

  @doc """
  Deletes `key` from `bucket`.

  Returns the current value of `key`, if `key` exists.
  """
  def delete(bucket, key) do
    # &Map.pop(&1, key) is the same as
    # fn state -> Map.pop(state, key) end
    Agent.get_and_update(bucket, &Map.pop(&1, key))
  end
end
