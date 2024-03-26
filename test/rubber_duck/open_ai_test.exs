defmodule RubberDuck.OpenAI.Test do
  @moduledoc false
  use ExUnit.Case

  alias RubberDuck.ChatCompletion.OpenAI

  describe "no money, no go" do
    test "response" do
      assert {:ok, %{status: 429, body: response}} =
               RubberDuck.ChatCompletion.call(
                 %{
                   model: "gpt-3.5-turbo",
                   messages: [%{role: "user", content: "Hello 3.5!"}]
                 },
                 engine: OpenAI
               )

      assert {:ok, %{status: 429, body: ^response}} =
               RubberDuck.ChatCompletion.call("Hi there!", [], OpenAI)

      assert %{"error" => %{"code" => "insufficient_quota"}} = response
    end
  end
end
