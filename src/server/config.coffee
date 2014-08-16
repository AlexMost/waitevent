
# Move this to some kid of ini config file
config =
    debug: true
    db_path: 'mongodb://33.33.33.10/waitevent'
    redis_host: "33.33.33.10"
    redis_port: "6379"


exports.get_config = -> config
