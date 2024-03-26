defmodule RubberDuck.OpenAI.Test do
  @moduledoc false
  use ExUnit.Case

  alias RubberDuck.ChatCompletion.OpenAi

  describe "No money, no go" do
    test "response" do
      assert {:ok, %{status: 429, body: response}} =
               RubberDuck.ChatCompletion.call(
                 %{
                   model: "gpt-3.5-turbo",
                   messages: [%{role: "user", content: "Hello 3.5!"}]
                 },
                 OpenAi
               )

      assert %{"error" => %{"code" => "insufficient_quota"}} = response
    end
  end
end
