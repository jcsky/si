class ThumbsUpMigration < ActiveRecord::Migration
  def self.up
    enable_extension 'uuid-ossp'
    create_table(:votes, id: :uuid, :force => true) do |t|

      t.boolean    :vote,     :default => false,    :null => false
      t.references :voteable, :polymorphic => true, :null => false, type: :uuid
      t.references :voter,    :polymorphic => true, type: :uuid

      t.timestamps

    end

    add_index :votes, [:voter_id, :voter_type]
    add_index :votes, [:voteable_id, :voteable_type]


    # Comment out the line below to allow multiple votes per voter on a single entity.
    add_index :votes, [:voter_id, :voter_type, :voteable_id, :voteable_type], :unique => true, :name => 'fk_one_vote_per_user_per_entity'

  end

  def self.down
    drop_table :votes
  end

end
