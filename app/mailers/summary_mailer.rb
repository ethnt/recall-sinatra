Recall::Web.mailer :summary do
  email :weekly do |user|
    from         ENV['AMAZON_SES_EMAIL']
    to           user.email
    subject      'Recall: Weekly assignment summary'
    locals       user: user
    render       'weekly_summary'
    content_type :html
  end
end
