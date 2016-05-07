class ImpressionPoliticianJob < ActiveRecord::Base
  belongs_to :impression
  belongs_to :politician_job
end
