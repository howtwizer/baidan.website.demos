Redis.current = Redis.new(
  host: ENV.fetch('REDIS_HOST', 'localhost'),
  port: ENV['REDIS_PORT'] || '6379'
)
