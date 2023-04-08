class GroupNoticeMailer < ApplicationMailer

  def send_mail(title, content, users)
    @mail_title = title
    @mail_content = content
    @users = users
    @users.each do |user|
      mail(
        to: user.email,
        subject: 'ご案内'
        )
      end
  end
end
