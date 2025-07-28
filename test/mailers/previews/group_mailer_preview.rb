# Preview all emails at http://localhost:3000/rails/mailers/group_mailer
class GroupMailerPreview < ActionMailer::Preview
  def preview_mail
    mail_title = 'test_title'
    mail_content = 'test_content'
    users = User.all
    group = Group.find(1)
    GroupMailer.send_mailer(mail_title, mail_content, group)
  end
end
