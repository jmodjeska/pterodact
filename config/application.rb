require File.expand_path('../boot', __FILE__)

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
require "csv"
require "iconv"

Bundler.require(*Rails.groups)

module Pterodact
  class Application < Rails::Application
    config.active_record.raise_in_transactional_callbacks = true
    config.assets.paths << Rails.root.join("app", "assets", "fonts")
    config.time_zone = 'Pacific Time (US & Canada)'
    config.active_record.default_timezone = :local
  end
end
