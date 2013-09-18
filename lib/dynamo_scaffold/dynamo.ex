defmodule DynamoScaffold.Dynamo do
  use Dynamo

  config :dynamo,
    # The environment this Dynamo runs on
    env: Mix.env,

    # The OTP application associated with this Dynamo
    otp_app: :dynamo_scaffold,

    # The endpoint to dispatch requests to
    endpoint: ApplicationRouter,

    # The route from which static assets are served
    # You can turn off static assets by setting it to false
    static_route: "/static"

  # Uncomment the lines below to enable the cookie session store
  # config :dynamo,
  #   session_store: Session.CookieStore,
  #   session_options:
  #     [ key: "_dynamo_scaffold_session",
  #       secret: "0nqGFf5qyLsOYU8P0NjKJ4xay80KN/VOVpEvRxix7dO6eCN2BWgz2wzWZL21utGK"]

  # Default functionality available in templates
  templates do
    use Dynamo.Helpers
  end
end
