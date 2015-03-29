ActionMailer::Base.smtp_settings = {
  address: "smtp.mandrillapp.com",
  port: 587,
  enable_starttls_auto: true,
  user_name: "designmarz@gmail.com",
  password: "ubbYv6wDtJu5N_4lHfJTdA",
  authentication: "login"
}

ActionMailer::Base.delivery_methods = :smtp
ActionMailer::Base.default charset:  "utf-8"

