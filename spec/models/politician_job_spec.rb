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

require 'rails_helper'

RSpec.describe PoliticianJob, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
