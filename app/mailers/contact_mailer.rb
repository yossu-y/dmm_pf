class ContactMailer < ApplicationMailer

  def send_mail(contact, user)
    @contact = contact
    mail to: ENV['TOMAIL'], bcc: ENV["ACTION_MAILER_USER"], subject: "【お問い合わせ】" + @contact.subject_i18n
  end

end
