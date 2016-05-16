class CalVoteHistoryWorker
  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { hourly(2).minute_of_hour(05) }

  def perform
    Impression.each do |impression|
      vh = VoteHistory.find_or_create_by(impression_id: impression.id, date_on: Date.today)
      vh.reputation = impression.reputation
      vh.upvote_user_ids = impression.voters_who_voted_for.pluck(:id)
      vh.downvote_user_ids = impression.voters_who_voted_against.pluck(:id)
      vh.save
    end
  end
end
