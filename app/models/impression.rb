# == Schema Information
#
# Table name: impressions
#
#  id              :uuid             not null, primary key
#  reputation      :integer          default(0)
#  official_name   :string
#  name            :string           not null
#  description     :text
#  impression_type :string
#  infos           :hstore
#  web_pages       :hstore
#  user_id         :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Impression < ActiveRecord::Base
  store_accessor :infos, [ :gender, :birthday, :email, :education, :image ]
  store_accessor :web_pages, [ :fb_fan_page, :website, :wiki, :g0v_legislator_api ]

  acts_as_voteable
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  acts_as_taggable_on :tags, :parties
  accepts_nested_attributes_for :taggings

  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  has_many :impression_politician_jobs, dependent: :destroy
  has_many :politician_jobs, through: :impression_politician_jobs

  validates :name, presence: true

  scope :politician, -> { where(impression_type: "politician") }

  def age
    Date.today.year - birthday.to_date.year if birthday.present?
  end

  def politician_job_names
    politician_jobs.pluck(:title).uniq.join(",")
  end

  def electoral_region_names
    politician_jobs.pluck(:electoral_region).uniq.join(",")
  end

end
