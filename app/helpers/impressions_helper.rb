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
#  gender          :string
#  birthday        :date
#  infos           :hstore
#  web_pages       :hstore
#  user_id         :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

module ImpressionsHelper
end
