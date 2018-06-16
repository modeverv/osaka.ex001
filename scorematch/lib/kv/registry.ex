defmodule KV.Registry do
  use GenServer

  # Client API

  def start_link opts \\ [] do
    GenServer.start_link __MODULE__, :ok, opts
  end

  def lookup server, name do
    GenServer.call server, {:lookup, name}
  end

  def create server, name do
    GenServer.cast server, {:create, name}
  end

  # Server Callbacks

  def init :ok do
    names = HashDict.new
    refs = HashDict.new
    {:ok, {names, refs}}
#     {:ok, HashDict.new}
  end

  def handle_call {:lookup, name}, _from, {names, _} = state do
    {:reply, HashDict.fetch(names, name), state}
  end

#   def handle_call {:lookup, name}, _from, names do
# 		{:reply, HashDict.fetch(names, name), names}
#   end

#   def handle_cast {:create, name}, names do
#     if HashDict.get names, name do
#       {:reply, names}
#     else
#       {:ok, bucket} = KV.Bucket.start_link
#       {:noreply, HashDict.put(names, name, bucket)}
#     end
#   end

  def handle_cast {:create, name}, {names, refs} do
    if HashDict.get names, name do
      {:reply, {names, refs}}
    else
      {:ok, bucket} = KV.Bucket.start_link
      ref = Process.monitor bucket
      refs = HashDict.put refs, ref, name
      names = HashDict.put names, name, bucket
      {:noreply, {names, refs}}
    end
  end

  def handle_info {:DOWN, ref, :process, _pid, _reason}, {names, refs} do
    {name, refs} = HashDict.pop refs, ref
    names = HashDict.delete names, name
    {:noreply, {names, refs}}
  end

  def handle_info msg, state do
    {:noreply, state}
  end

end
 
