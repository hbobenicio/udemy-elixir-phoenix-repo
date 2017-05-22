# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :discuss,
  ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XuueFng5D/yERljPeewzxQHXs6zK4vlpN2N3ZHJDaIN7Fd5DUZdkPfZEhG/evAsa",
  render_errors: [view: Discuss.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Configures the Überauth (OAuth Library)
# @see https://github.com/ueberauth/ueberauth
config :ueberauth, Ueberauth,
  providers: [
    # facebook: { Ueberauth.Strategy.Facebook, [ opt1: "value", opts2: "value" ] },
    github: { Ueberauth.Strategy.Github, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: System.get_env("OAUTH_DISCUSS_GITHUB_CLIENT_ID"),
  client_secret: System.get_env("OAUTH_DISCUSS_GITHUB_CLIENT_SECRET")

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
