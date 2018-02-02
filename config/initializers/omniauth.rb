OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '632573089183-1k7118puudpe7sqm8se7c43cjmm7g6u3.apps.googleusercontent.com', 'r626xdoqMZnaLiU5zg9jH5yN', {client_options: {ssl: {ca_file: Rails.root.join("cacert.pem").to_s}}}
end