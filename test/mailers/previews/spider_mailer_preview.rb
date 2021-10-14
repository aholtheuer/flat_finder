# Preview all emails at http://localhost:3000/rails/mailers/spider_mailer
class SpiderMailerPreview < ActionMailer::Preview
  def spider_email
    SpiderMailer.with(search_param: SearchParam.last,
                      search_param_flats: SearchParam.last.search_param_flats).spider_email
  end
end
