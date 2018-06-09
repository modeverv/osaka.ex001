defmodule FizzbuzzTest do
  use ExUnit.Case
  doctest Fizzbuzz

  test "greets the world" do
    assert Fizzbuzz.hello() == :world
  end
	
  test "1" do
    assert 1 == Fizzbuzz.fizzbuzz(1)
  end
 
  test "2" do
    assert 2 == Fizzbuzz.fizzbuzz(2)
  end
 
  test "eli" do
    assert "ハラショー" == Fizzbuzz.fizzbuzz(3)
  end
 
  test "kotori" do
    assert "ちゅんちゅん" == Fizzbuzz.fizzbuzz(5)
  end
 
  test "nico" do
    assert "にっこにっこにー☆" == Fizzbuzz.fizzbuzz(15) 
  end
	
end
