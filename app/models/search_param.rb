class SearchParam < ApplicationRecord
  before_destroy :disable_cron_job

  belongs_to :user
  has_many :search_param_flats, dependent: :destroy
  has_many :flats, through: :search_param_flats
  validates :title, presence: true, length: {minimum: 3, maximum: 105}

  private

  def disable_cron_job
    begin
      cron_job = Sidekiq::Cron::Job.find "SpiderJob_SP#{self.id}"
      cron_job.disable!
      cron_job.destroy
    rescue 
      puts "------------No existe Cron Job------------------------"
    end
  end

end
