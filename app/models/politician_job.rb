# == Schema Information
#
# Table name: politician_jobs
#
#  id               :uuid             not null, primary key
#  organization     :string
#  title            :string
#  electoral_region :string
#  th               :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#

class PoliticianJob < ActiveRecord::Base
  has_many :impression_politician_jobs
  has_many :impressions, through: :impression_politician_jobs
end
