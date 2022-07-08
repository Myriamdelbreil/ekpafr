require "active_support/core_ext/integer/time"

Rails.application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded any time
  # it changes. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports.
  config.consider_all_requests_local = true

  # Enable server timing
  config.server_timing = true

  # Enable/disable caching. By default caching is disabled.
  # Run rails dev:cache to toggle caching.
  if Rails.root.join("tmp/caching-dev.txt").exist?
    config.action_controller.perform_caching = true
    config.action_controller.enable_fragment_cache_logging = true

    config.cache_store = :memory_store
    config.public_file_server.headers = {
      "Cache-Control" => "public, max-age=#{2.days.to_i}"
    }
  else
    config.action_controller.perform_caching = false

    config.cache_store = :null_store
  end

  # Store uploaded files on the local file system (see config/storage.yml for options).
  config.active_storage.service = :cloudinary

  # Don't care if the mailer can't send.
  # config.action_mailer.raise_delivery_errors = false

  config.action_mailer.perform_caching = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise exceptions for disallowed deprecations.
  config.active_support.disallowed_deprecation = :raise

  # Tell Active Support which deprecation messages to disallow.
  config.active_support.disallowed_deprecation_warnings = []

  # Raise an error on page load if there are pending migrations.
  config.active_record.migration_error = :page_load

  # Highlight code that triggered database queries in logs.
  config.active_record.verbose_query_logs = true

  # Suppress logger output for asset requests.
  config.assets.quiet = true

  # Raises error for missing translations.
  # config.i18n.raise_on_missing_translations = true

  # Annotate rendered view with file names.
  # config.action_view.annotate_rendered_view_with_filenames = true

  # Uncomment if you wish to allow Action Cable access from any origin.
  # config.action_cable.disable_request_forgery_protection = true

  # config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }

  config.action_mailer.default_url_options = { :host => "localhost:3000" }
  config.action_mailer.delivery_method = :smtp
  config.action_mailer.perform_deliveries = true
  config.action_mailer.raise_delivery_errors = true

  #mailjet config => corriger stmp
  # config.action_mailer.delivery_method = :mailjet_stmp
  # config.action_mailer.smtp_settings = {
  #   address: 'smtp.gmail.com',
  #   domain: 'gmail.com',
  #   port: 587,
  #   user_name: 'spoots.app@gmail.com',
  #   password: ENV["GMAIL_KEY"],
  #   authentication: 'plain',
  #   enable_starttls_auto: true
  # }
  # Mailjet.configure do |config|
  #   config.api_key = ENV['MJ_APIKEY_PUBLIC']
  #   config.secret_key = ENV['MJ_APIKEY_PRIVATE']
  #   config.default_from = 'myriam.delbreil@live.fr'
  #   # Mailjet API v3.1 is at the moment limited to Send API.
  #   # We’ve not set the version to it directly since there is no other endpoint in that version.
  #   # We recommend you create a dedicated instance of the wrapper set with it to send your emails.
  #   # If you're only using the gem to send emails, then you can safely set it to this version.
  #   # Otherwise, you can remove the dedicated line into config/initializers/mailjet.rb.
  #   config.api_version = 'v3.1'
  # end


  config.action_mailer.smtp_settings = {
    :address => 'smtp-relay.sendinblue.com',
    :port => 587,
    :user_name => 'YOUR_SENDINBLUE_EMAIL',
    :password => 'YOUR_SENDINBLUE_PASSWORD',
    :authentication => 'login',
    :enable_starttls_auto => true
  }
end
