require './app'

Encoding.default_external = 'utf-8'

# TODO: actually pull this from the env
ENV['MEMCACHE_SERVERS'] = 'memcached'

if memcache_servers = ENV['MEMCACHE_SERVERS']
  use Rack::Cache,
    verbose: true,
    metastore:   "memcached://#{memcache_servers}",
    entitystore: "memcached://#{memcache_servers}"
end

run App
