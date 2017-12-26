Raven.configure do |config|
    config.dsn = 'http://9f227160748341d8a507b8cceadac29e:0f211440636840ed8484dd23fb9a72f7@sentry.io/263921'
    config.sanitize_fields = Rails.application.config.filter_parameters.map(&:to_s)

end
