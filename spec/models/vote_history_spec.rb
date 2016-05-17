# == Schema Information
#
# Table name: vote_histories
#
#  id                :uuid             not null, primary key
#  impression_id     :uuid
#  reputation        :integer
#  upvote_user_ids   :text
#  downvote_user_ids :text
#  date_on           :date
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'rails_helper'

RSpec.describe VoteHistory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
