IO.puts "aaaaa日本語鴎外"

IO.puts String.length "にこにこにー"                # => 6
IO.puts byte_size "にこにこにー"                    # => 18
IO.puts String.at "スピリチュアル", 2               # => "リ"
IO.puts String.split "ラブアロー☆シュート！", "☆"  # => ["ラブアロー", "シュート！"]

["知らないLove*教えてLove", "微熱からMistery", "秋のあなたの空遠く"]

[25, :nico, "にー"]

hd [25, :nico, "にー"]

hd [25, :nico, "にー"]           # => 25
tl [25, :nico, "にー", :aaa]           # => [:nico, "にー"]
Enum.at [25, :nico, "にー"], 1   # => :nico

elem {25, :nico, "にー"}, 1

%{:umi => 2, :rin => 1, :nozomi => 3}

ge = %{:umi => 2, :rin => 1, :nozomi => 3}
map1 = %{:umi => 2, :rin => 1, :nozomi => 3}
map2 = %{map1 | :rin => 4}
[umi: 2, rin: 1, nozomi: 3][:rin]

idol = "rin"     # "rin"
IO.puts idol     # "rin"

idol = "rin"     # "rin"
"rin" = idol     # "rin"

# {rin, umi, nozomi} = {"hoshizora", "sonoda", "tojo", "yazawa"} 
# {rin, umi, nozomi} = {"hoshizora", "sonoda", "tojo"}  

unit = {"umi", "rin", "nozomi"}
r = case unit do
    {"nico", "maki", "eli"} -> "BiBi"
    {"umi", "rin", "nozomi"} -> "lily white"
    {"honoka", "kotori", "hanayo"} -> "Printemps"
    _ -> "New Unit"
end
IO.puts r     # "lily white"

unit = {"umi", "rin", "nozomi"}
r = case unit do
    {"nico", "maki", "eli"} -> "BiBi"
    {"umi", "rin", "nozomi"} -> "lily white"
    {"honoka", "kotori", "hanayo"} -> "Printemps"
    _ -> "New Unit"
end

x = "maki"
r = case {"maki", "rin", "pana"} do
  {x, "rin", "pana"} when x == "maki" -> "まきりんぱな"
  {x, "rin", "pana"} when x == "nico" -> "にこりんぱな"
  _ -> "New Unit"
end
IO.puts "r is #{r}"
IO.puts "x is #{x}"

defmodule Idol do
  def nico name do
    "みんなのアイドル、#{name}だよー。にっこにっこにー☆"
  end
end

defmodule Idol do
	def nico name do
		"みんなのアイドル、#{name}だよー。にっこにっこにー☆"
	end
end

IO.puts Idol.nico "海未ちゃん"
IO.puts Idol.nico "凛ちゃん"

nico = fn name -> "みんなのアイドル、#{name}だよー。にっこにっこにー☆" end
nico.("にこにー")    # みんなのアイドル、にこにーだよー。にっこにっこにー☆

Enum.map ["うみ", "りん", "のぞ"], fn x -> x <> x end

defmodule Idol do
  def favorite(thing, n) when n == 1 do
    IO.puts thing
  end
  def favorite(thing, n) do
    IO.puts thing
    favorite thing, n - 1
  end
end
Idol.favorite "ラーメン", 3

["うみ", "りん", "のぞ"]|> Enum.map(fn x -> x <> x end)|> Enum.reduce("", fn x, acc -> acc <> x end)

["うみ", "りん", "のぞ"] \
|> Enum.map(fn x -> x <> x end) \
|> Enum.reduce("", fn x, acc -> acc <> x end)
|> IO.puts

data = ["うみ", "りん", "のぞ"]
tmp = Enum.map data, fn x -> x <> x end
Enum.reduce tmp, "", fn x, acc -> acc <> x end


m = ["ほの", "こと", "うみ", "まき", "りん", "ぱな", "にこ", "のぞ", "えり"]
 
# Enum
IO.inspect m
  |> Enum.filter(fn x -> x in ["うみ", "りん", "のぞ"] end)
  |> Enum.map(fn x -> x <> x end)
 
#Stream
s = m
  |> Stream.filter(fn x -> x in ["うみ", "りん", "のぞ"] end)
  |> Stream.map(fn x -> x <> x end)
IO.inspect Enum.to_list s

Path.join "umi", "kotori"    # umi/kotori
Path.expand "~/kotori"       # /home/umi/kotori
 
try do
  raise "ハラショー・・・"
rescue
  e in RuntimeError -> IO.inspect e  # %RuntimeError{message: "ハラショー・・・"}
end



defmodule SchoolIdol do
  defstruct name: "", age: 0, school: ""
end
 
defmodule ProfessionalIdol do
  defstruct name: "", age: 0
end
 
defmodule StreetSinger do
  defstruct name: ""
end
 
defprotocol Idol do
  def introduce idol
end
 
defimpl Idol, for: SchoolIdol do
  def introduce idol do
    "#{idol.school}所属、#{idol.name}、#{idol.age}歳です♪"
  end
end
 
defimpl Idol, for: ProfessionalIdol do
  def introduce idol do
    "#{idol.name}、#{idol.age}歳です☆"
  end
end

defimpl Idol, for: StreetSinger do
	def introduce idol do
		"#{idol.name}です！！"
	end
end


defmodule Main do
  require SchoolIdol
  require ProfessionalIdol
  require StreetSinger
 
  def info do
    umi = %SchoolIdol{name: "園田海未", age: 16, school: "音ノ木坂学院"}
    yukari = %ProfessionalIdol{name: "島村卯月", age: 17}
    honoka = %StreetSinger{name: "高坂穂乃果"}
 
    IO.puts Idol.introduce umi
    IO.puts Idol.introduce yukari
    IO.puts Idol.introduce honoka
  end
end
 
Main.info


defmodule Idol do
  defstruct name: ""
end
 
defmodule IdolSigil do
  require Idol
  def sigil_i string, [] do
    %Idol{name: string}
  end
end
 
defmodule Main do
  require Idol
  import IdolSigil
  def main do
    IO.inspect ~i(Umi Sonoda)    # %Idol{name: "Umi Sonoda"}
  end
end
 
Main.main

pid = spawn fn -> IO.puts "ラブアロー☆シュート！" end

parent = self()
spawn fn -> send parent, {:hi, "いくよFull Combo!"} end
receive do
  {:hi, msg} -> IO.puts msg
end

parent = self()
spawn fn -> send parent, {:hi, "いくよFull Combo!"} end
receive do
  {:hello, msg} -> IO.puts msg
after
  3_000 -> IO.puts "メッセージ来ないにゃ・・・"
end
