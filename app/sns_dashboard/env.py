import environ

root = environ.Path(__file__) - 1
env = environ.Env()

# Load from $ENV_FILE or .env if ENV_FILE not set
#environ.Env.read_env()
