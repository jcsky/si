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

class Impression < ActiveRecord::Base
  store_accessor :infos
  store_accessor :web_pages
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_one :politician
  acts_as_voteable

  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags, :current_jobs, :current_locations, :parties
  accepts_nested_attributes_for :taggings
end
