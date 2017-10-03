# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :cheetah_api,
  ecto_repos: [CheetahApi.Repo]

# Configures the endpoint
config :cheetah_api, CheetahApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "uJby0bTasLmCZeqaE/m0fuYrGeXP13sHYlpDWQzI0hfXY9siiaTjoyOuzSFy4BUs",
  render_errors: [view: CheetahApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: CheetahApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# Ueberauth Config for oauth
config :ueberauth, Ueberauth,
base_path: "/api/v1/auth",
providers: [
  google: { Ueberauth.Strategy.Google, [] },
  identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      uid_field: :username,
      nickname_field: :username,
    ] },
]

# Ueberauth Strategy Config for Google oauth
config :ueberauth, Ueberauth.Strategy.Google.OAuth,
client_id: System.get_env("GOOGLE_CLIENT_ID"),
client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")

# Guardian configuration
config :guardian, Guardian,
allowed_algos: ["HS512"], # optional
verify_module: Guardian.JWT,  # optional
issuer: "SocialAppApi",
ttl: { 30, :days },
allowed_drift: 2000,
verify_issuer: true, # optional
secret_key: System.get_env("GUARDIAN_SECRET") || "rFtDNsugNi8jNJLOfvcN4jVyS/V7Sh+9pBtc/J30W8h4MYTcbiLYf/8CEVfdgU6/",
serializer: SocialAppApi.GuardianSerializer
