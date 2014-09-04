config =
    debug: process.env.DEBUG
    db_path: process.env.MONGO_CONNECTION
    redis_host: process.env.REDIS_HOST
    redis_port: process.env.REDIS_PORT
    redis_pass: process.env.REDIS_PASS
    redis_db: process.env.REDIS_DB
    port: process.env.PORT
    hostname: process.env.HOSTNAME
    googleClientId: process.env.GOOGLE_CLIENT_ID
    googleClientSecret: process.env.GOOGLE_CLIENT_SECRET
    local: process.env.LOCAL

exports.get_config = ->
    console.log config
    config
