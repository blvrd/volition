SMTP_SETTINGS = {
  address: ENV.fetch("SMTP_ADDRESS"), # example: "smtp.sendgrid.net"
  authentication: :login,
  enable_starttls_auto: true,
  domain: ENV.fetch("SMTP_DOMAIN"),
  user_name: ENV.fetch("SMTP_USERNAME"),
  password: ENV.fetch("SMTP_PASSWORD"),
  port: "587"
}

if ENV["EMAIL_RECIPIENTS"].present?
  Mail.register_interceptor RecipientInterceptor.new(ENV["EMAIL_RECIPIENTS"])
end
