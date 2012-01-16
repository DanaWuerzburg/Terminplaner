class Notifier < ActionMailer::Base
  default from: "rubyprojekt@googlemail.com"

  def activation_instructions(user)
    from          "Binary Logic Notifier <noreply@binarylogic.com>"

    @account_activation_url = activate_account_url(user.perishable_token)
    @user_link = user.login

    mail(:to => user.email_address_with_name,
         :subject => "Activation Instructions",
         :from => from,
         :fail_to => from
    ) do |format|
      format.text
    end
  end

  def activation_confirmation(user)
    from          "Binary Logic Notifier <noreply@binarylogic.com>"
    @user_link = user.login

    mail(:to => user.email_address_with_name,
         :subject => "Activation Complete",
         :from => from,
         :fail_to => from
    ) do |format|
      format.text
    end
  end


  #forgot password 2.
  default_url_options[:host] = "0.0.0.0:3000"

  def password_reset_instructions(user)
    from          "Binary Logic Notifier <noreply@binarylogic.com>"

    @reset_password_link = edit_password_reset_url(user.perishable_token)
    @user_link = user.login

    mail(:to => user.email_address_with_name,
         :subject => "Password Reset Instructions",
         :from => from,
         :fail_to => from
    ) do |format|
      format.text
    end

  end

end
