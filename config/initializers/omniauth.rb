Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: 'email profile https://www.googleapis.com/auth/calendar.events',
    prompt: 'consent',
    access_type: 'offline',
    approval_prompt: 'force'
  }
end

OmniAuth.config.allowed_request_methods = [:post, :get]