# == Schema Information
#
# Table name: politicians
#
#  id          :uuid             not null, primary key
#  birthday    :date
#  age         :integer
#  current_job :string
#  gender      :string
#  party       :string
#  image       :string
#  email       :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

require 'rails_helper'

RSpec.describe Politician, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
