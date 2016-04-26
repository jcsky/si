# == Schema Information
#
# Table name: impressions
#
#  id              :uuid             not null, primary key
#  reputation      :integer
#  official_name   :string
#  name            :string
#  description     :text
#  impression_type :string
#  infos           :hstore
#  web_pages       :hstore
#  user_id         :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

require 'rails_helper'

RSpec.describe ImpressionsController, type: :controller do

end
