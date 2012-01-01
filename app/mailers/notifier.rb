class Notifier < ActionMailer::Base
  default from: "s0524073@htw-berlin.de"

  def activation_instructions(user)
    from          "Binary Logic Notifier <noreply@binarylogic.com>"

    @account_activation_url = activate_account_url(user.perishable_token)

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

    mail(:to => user.email_address_with_name,
         :subject => "Activation Complete",
         :from => from,
         :fail_to => from
    ) do |format|
      format.text
    end
  end

end
