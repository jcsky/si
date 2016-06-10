class VoteHistoryAddUniqIndex < ActiveRecord::Migration
  def change
    add_index :vote_histories, [:impression_id, :date_on], :unique => true
  end
end
