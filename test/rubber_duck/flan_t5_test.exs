defmodule RubberDuck.FlanT5.Test do
  @moduledoc false
  use ExUnit.Case

  alias RubberDuck.ChatCompletion.FlanT5

  describe "for those extremely patient" do
    @tag :skip
    test "response" do
      assert [
               results: [
                 %{
                   text: "Elixir is a steroid.",
                   token_summary: %{input: 8, output: 12, padding: 0}
                 }
               ]
             ] =
               RubberDuck.ChatCompletion.call("Elixir is a",
                 engine: FlanT5
               )
    end
  end
end
