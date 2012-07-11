class UserMailer < ActionMailer::Base
default :from => "edunjoroge@gmail.com"
def registration_confirmation(user)
	mail(:to => user.email, :subject => "Signed Up")
end

end
