# lib/kv/bucket.ex
defmodule KV.Bucket do
  def start_link do
    Agent.start_link fn -> HashDict.new end
  end
 
  def get bucket, key do
    Agent.get bucket, fn bucket -> HashDict.get bucket, key end
  end
 
  def put bucket, key, value do
    Agent.update bucket, fn bucket -> HashDict.put bucket, key, value end
  end

  def delete bucket, key do
    Agent.get_and_update bucket, fn bucket -> HashDict.pop bucket, key end
  end

end

