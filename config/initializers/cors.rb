Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'localhost:13000'
    resource '*',
      headers: :any,
      methods: %i[get post put patch delete options head],
      credentials: true  # クッキーを含めるために必要
  end
end
