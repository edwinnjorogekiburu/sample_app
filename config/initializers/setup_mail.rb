if Rails.env != 'test'
  email_settings = YAML::load(File.open("#{Rails.root.to_s}/config/email.yml"))
  ActionMailer::Base.smtp_settings = email_settings[Rails.env] unless email_settings[Rails.env].nil?
end
ActionMailer::Base.default_url_options[:host] = "localhost:3000"

ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
	:address => "smtp.gmail.com",
	:port => 587,
	:domain => "aimsell.net",
	:user_name => "edunjoroge@gmail.com",
	:password => "07091986",
	:authentication => :plain,
	:enable_starttlls_auto => true
}
