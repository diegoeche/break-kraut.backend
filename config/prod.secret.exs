use Mix.Config

# In this file, we keep production configuration that
# you likely want to automate and keep it away from
# your version control system.
config :backend, Backend.Endpoint,
  secret_key_base: "MpbcGtJoVP3jjjPnqnTGozQhvWtz62XwZiIAIVxoKiLLMBqvSTuj+ynB9CYbjaAh"

# Configure your database
config :backend, Backend.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "backend_prod",
  pool_size: 20
