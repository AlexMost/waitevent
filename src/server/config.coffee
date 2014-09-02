
# Move this to some kid of ini config file
config =
    debug: process.env.DEBUG
    db_path: process.env.MONGO_CONNECTION
    redis_host: process.env.REDIS_HOST
    redis_port: process.env.REIDS_PORT
    port: process.env.PORT
    hostname: process.env.HOSTNAME



exports.get_config = -> config
