import Config

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime

# Enable helpful, but potentially expensive runtime checks
config :phoenix_live_view,
  enable_expensive_runtime_checks: true

# In test we don't send emails
config :radio_api, RadioApi.Mailer, adapter: Swoosh.Adapters.Test

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :radio_api, RadioApi.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "radio_api_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :radio_api, RadioApiWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yhrICu5CADUzcJAYAliglq5hjonfaJBcE27aKnOGkJuKzn4WWV9b1cHOgZj2YzUG",
  server: false

# Disable swoosh api client as it is only required for production adapters
config :swoosh, :api_client, false
