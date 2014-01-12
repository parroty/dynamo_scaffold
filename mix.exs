defmodule DynamoScaffold.Mixfile do
  use Mix.Project

  def project do
    [ app: :dynamo_scaffold,
      version: "0.0.1",
      build_per_environment: true,
      dynamos: [DynamoScaffold.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [ applications: [:cowboy, :dynamo],
      mod: { DynamoScaffold, [] } ]
  end

  defp deps do
    [
      { :cowboy, github: "extend/cowboy" },
      { :postgrex, github: "ericmj/postgrex", optional: true },
      { :ecto, github: "elixir-lang/ecto" },
      { :dynamo, "~> 0.1.0-dev", github: "elixir-lang/dynamo"}
    ]
  end
end
