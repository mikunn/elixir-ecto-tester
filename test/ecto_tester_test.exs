defmodule EctoTesterTest do
  use ExUnit.Case
  doctest EctoTester

  test "greets the world" do
    assert EctoTester.hello() == :world
  end
end
