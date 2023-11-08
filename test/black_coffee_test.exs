defmodule BlackCoffeeTest do
  use ExUnit.Case
  doctest BlackCoffee

  test "greets the world" do
    assert BlackCoffee.hello() == :world
  end
end
