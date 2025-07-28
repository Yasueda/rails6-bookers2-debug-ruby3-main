class GroupMailer < ApplicationMailer

  def send_mailer(mail_title, mail_content, group) #メソッドに対して引数を設定
    @mail_title = mail_title
    @mail_content = mail_content
    @group = group
    mail bcc: group.users.pluck(:email), subject: mail_title
  end
  
end
