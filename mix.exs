defmodule DynamoScaffold.Mixfile do
  use Mix.Project

  def project do
    [ app: :dynamo_scaffold,
      version: "0.0.1",
      dynamos: [DynamoScaffold.Dynamo],
      compilers: [:elixir, :dynamo, :app],
      env: [prod: [compile_path: "ebin"]],
      compile_path: "tmp/#{Mix.env}/dynamo_scaffold/ebin",
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
      { :dynamo, "0.1.0-dev", github: "parroty/dynamo", branch: "feature" } ,
      { :ecto, github: "elixir-lang/ecto" },
      { :pgsql, github: "ericmj/pgsql", branch: "elixir" }
    ]
  end
end
