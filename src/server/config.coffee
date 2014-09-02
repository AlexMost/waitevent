config =
    debug: process.env.DEBUG
    db_path: process.env.MONGO_CONNECTION
    redis_host: process.env.REDIS_HOST
    redis_port: process.env.REIDS_PORT
    redis_pass: process.env.REDIS_PASS
    port: process.env.PORT
    hostname: process.env.HOSTNAME

exports.get_config = -> config
