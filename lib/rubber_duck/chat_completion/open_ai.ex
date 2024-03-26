defmodule RubberDuck.ChatCompletion.OpenAi do
  @chat_completions_url "https://api.openai.com/v1/chat/completions"

  @behaviour RubberDuck.ChatCompletion

  @impl RubberDuck.ChatCompletion
  def call(request) do
    Req.post(@chat_completions_url,
      json: request,
      auth: {:bearer, api_key()}
    )
  end

  defp api_key do
    Application.get_env(:rubber_duck, :open_ai_key)
  end
end
