class CreateVoteHistories < ActiveRecord::Migration
  def change
    create_table :vote_histories, id: :uuid do |t|
      t.uuid    :impression_id
      t.integer :reputation
      t.text    :upvote_user_ids
      t.text    :downvote_user_ids
      t.date    :date_on
      t.timestamps null: false
    end
    add_index :vote_histories, :impression_id
  end
end
