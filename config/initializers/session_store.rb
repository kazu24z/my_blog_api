# config/initializers/session_store.rb
Rails.application.config.session_store :cookie_store, key: '_auth_token', httponly: true, secure: Rails.env.production?
