class SpiderMailer < ApplicationMailer

  def spider_email
      @search_param = params[:search_param]
      @search_param_flats = @search_param.search_param_flats.where(emailed_at: nil)
      mail(to: @search_param.user.email, subject: 'The Spider has found new Flats!')
      # Only Updated if mail was succesfully sent
      @search_param_flats.update(emailed_at: Time.now)
  end
end
