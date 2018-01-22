require_relative 'boot'
require 'rails/all'
Bundler.require(*Rails.groups)
module TodoApp
  class Application < Rails::Application
    config.assets.quiet = true
    config.generators do |generate|
      generate.helper false
      generate.javascript_engine false
      generate.request_specs false
      generate.routing_specs false
      generate.stylesheets false
      generate.test_framework :test_unit
      generate.view_specs false
    end
    config.action_controller.action_on_unpermitted_parameters = :raise
    config.middleware.insert_after ActionDispatch::Static, Rack::Deflater
    config.active_job.queue_adapter = :sidekiq
    config.react.addons = true
    config.autoload_paths += Dir[Rails.root.join('app', 'models', '{*/}')]

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', :headers => :any, :methods => [:get, :post, :options]
      end
    end

  end
end
