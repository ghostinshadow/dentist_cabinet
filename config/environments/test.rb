Rails.application.configure do
config.cache_classes = true


config.eager_load = false

  # Configure public file server for tests with Cache-Control for performance.
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=3600'
  }

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates.
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment.
  config.action_controller.allow_forgery_protection = false
  config.action_mailer.perform_caching = false

  config.action_mailer.delivery_method = :test

  # Print deprecation notices to the stderr.
  config.active_support.deprecation = :stderr

  config.action_dispatch.default_headers.merge!(
  {
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Allow-Methods' => 'POST, PUT, DELETE, GET, OPTIONS',
      'Access-Control-Max-Age' => "1728000",
     'Access-Control-Allow-Headers' =>'Origin, X-Requested-With, Content-Type, Accept, Authorization'
  })

  # Raises error for missing translations
  # config.action_view.raise_on_missing_translations = true
end
