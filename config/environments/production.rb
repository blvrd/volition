require Rails.root.join("config/smtp")
Rails.application.configure do
  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.cache_store = :redis_store, ENV['REDISTOGO_URL']
  config.public_file_server.enabled = ENV['RAILS_SERVE_STATIC_FILES'].present?
  config.assets.js_compressor = Uglifier.new(harmony: true)
  config.assets.compile = true
  config.action_controller.asset_host = ENV.fetch("ASSET_HOST", ENV["APPLICATION_HOST"])
  config.log_level = :debug
  config.log_tags = [ :request_id ]
  config.action_mailer.perform_caching = false
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.smtp_settings = SMTP_SETTINGS
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  config.log_formatter = ::Logger::Formatter.new
  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger = ActiveSupport::TaggedLogging.new(logger)
  end
  config.active_record.dump_schema_after_migration = false
  config.static_cache_control = "public, max-age=31557600"
  config.action_mailer.default_url_options = { host: ENV["APPLICATION_HOST"] }
end
Rack::Timeout.timeout = (ENV["RACK_TIMEOUT"] || 10).to_i
