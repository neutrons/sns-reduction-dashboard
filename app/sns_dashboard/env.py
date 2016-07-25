import environ

root = environ.Path(__file__) - 3 # three folders back (/a/b/c/ - 3 = /)
env = environ.Env()

# Load from $ENV_FILE or .env if ENV_FILE not set
#environ.Env.read_env()
