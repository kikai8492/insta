require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Insta
  class Application < Rails::Application
    config.load_defaults 6.1
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja
    
    config.generators do |g|
      g.assets false
      g.helper false
    end
  end
end
