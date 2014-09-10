config =
    debug: process.env.DEBUG is "true"
    db_path: process.env.MONGO_CONNECTION
    redis_host: process.env.REDIS_HOST
    redis_port: process.env.REDIS_PORT
    redis_pass: process.env.REDIS_PASS or undefined
    redis_db: parseInt process.env.REDIS_DB
    port: process.env.PORT
    hostname: process.env.HOSTNAME
    googleClientId: process.env.GOOGLE_CLIENT_ID
    googleClientSecret: process.env.GOOGLE_CLIENT_SECRET
    local: process.env.LOCAL is "true"

exports.get_config = ->
    console.log config
    config
