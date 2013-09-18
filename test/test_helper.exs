Dynamo.under_test(DynamoScaffold.Dynamo)
Dynamo.Loader.enable
ExUnit.start

defmodule DynamoScaffold.TestCase do
  use ExUnit.CaseTemplate

  # Enable code reloading on test cases
  setup do
    Dynamo.Loader.enable
    :ok
  end
end
