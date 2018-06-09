defmodule Fizzbuzz do
  @moduledoc """
  Documentation for Fizzbuzz.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Fizzbuzz.hello
      :world

  """
  def hello do
    :world
  end
	
  defmacro nicomacro name do
    quote do: "みんなのアイドル、#{unquote(name)}だよー。にっこにっこにー☆"
  end

	def main args do
		IO.puts "hello world!"

    x = String.to_integer hd args
    cond do
      rem(x, 3) == 0 and rem(x, 5) == 0 -> IO.puts "にっこにっこにー☆"
      rem(x, 3) == 0 -> IO.puts "ハラショー"
      rem(x, 5) == 0 -> IO.puts "ちゅんちゅん"
      true -> IO.puts x
    end
		IO.puts nicomacro "凛" <> "ちゃん"
		hoge()
	end

	def hoge do
		IO.puts "aaaa"
	end

  def fizzbuzz n do
    cond do
      rem(n, 3) == 0 and rem(n, 5) == 0 -> "にっこにっこにー☆"
      rem(n, 3) == 0 -> "ハラショー"
      rem(n, 5) == 0 -> "ちゅんちゅん"
      true -> n
    end
  end

end

