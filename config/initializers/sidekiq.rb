Sidekiq.configure_server do |config|
  config.redis = {
    url: 'redis://si.z127fz.0001.apne1.cache.amazonaws.com:6379/0',
    namespace: 'si_sidekiq'
  }
end
