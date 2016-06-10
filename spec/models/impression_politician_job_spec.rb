# == Schema Information
#
# Table name: impression_politician_jobs
#
#  id                :uuid             not null, primary key
#  impression_id     :uuid
#  politician_job_id :uuid
#  started_on        :date
#  ended_on          :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe ImpressionPoliticianJob, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
