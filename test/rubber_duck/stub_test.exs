defmodule RubberDuck.Stub.Test do
  @moduledoc false
  use ExUnit.Case

  alias RubberDuck.ChatCompletion.Stub

  describe "echoes the request" do
    test "response" do
      assert "Hi, as a stub code, I can only mirror your request: ‹\"Elixir is a\"›" =
               RubberDuck.ChatCompletion.call("Elixir is a", engine: Stub)
    end
  end
end
