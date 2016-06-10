class CalVoteHistoryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(1).minute_of_hour(05) }

  def perform
    Impression.all.each do |impression|
      vh = VoteHistory.find_or_create_by(impression_id: impression.id, date_on: Date.today)
      vh.reputation = impression.reputation || 0
      vh.upvote_user_ids = impression.votes.where(vote: true).pluck(:voter_id)
      vh.downvote_user_ids = impression.votes.where(vote: false).pluck(:voter_id)
      vh.save if vh.upvote_user_ids.present? or vh.downvote_user_ids.present?
    end
  end
end
