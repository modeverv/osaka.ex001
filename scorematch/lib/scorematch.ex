defmodule Scorematch do
  @moduledoc """
  Documentation for Scorematch.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Scorematch.hello
      :world

  """
  def hello do
    :world
  end

  def main args do
    {:ok, registry} = KV.Registry.start_link
    KV.Registry.create registry, "card1"
    {:ok, bucket} = KV.Registry.lookup registry, "card1"
    Agent.stop bucket
    {:ok, bucket} = KV.Registry.lookup registry, "card1"
    IO.inspect Process.alive? bucket

#     {:ok, registry} = KV.Registry.start_link
#     KV.Registry.create registry, "card1"
#     {:ok, bucket} = KV.Registry.lookup registry, "card1"
#     KV.Bucket.put bucket, "園田ことり", "いくよFull Combo!"
#     IO.puts KV.Bucket.get bucket, "園田ことり"
  end


#  def main(args) do
#    {:ok, bucket} = KV.Bucket.start_link()
#    KV.Bucket.put(bucket, "園田ことり", "いくよFull Combo!")
#    KV.Bucket.put(bucket, "隣の人フルコンします", "この曲好き！")
##    KV.Bucket.delete(bucket, "園田ことり")
#    IO.puts(KV.Bucket.get(bucket, "園田ことり"))
#    IO.puts(KV.Bucket.get(bucket, "隣の人フルコンします"))
#  end
end
