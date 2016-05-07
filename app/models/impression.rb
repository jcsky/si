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

class Impression < ActiveRecord::Base
  store_accessor :infos, [ :gender, :birthday, :email ]
  store_accessor :web_pages, [ :fb_fan_page, :website, :wiki ]

  acts_as_voteable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags, :parties, :jobs, :past_jobs, :electoral_districts
  accepts_nested_attributes_for :taggings

  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :impression_politician_jobs
  has_many :politician_jobs, through: :impression_politician_jobs

  validates :name, presence: true

  scope :politician, -> { where(impression_type: "politician") }

  def age
    Date.today.year - birthday.to_date.year if birthday.present?
  end

end
