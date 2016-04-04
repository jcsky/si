class Impression < ActiveRecord::Base
  store_accessor :infos
  store_accessor :web_pages
  belongs_to :owner, class_name: "User", foreign_key: "user_id"
  acts_as_voteable
  
end
