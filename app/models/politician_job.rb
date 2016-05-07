class PoliticianJob < ActiveRecord::Base
  has_many :impression_politician_jobs
  has_many :impressions, through: :impression_politician_jobs
end
