class CreatePoliticianJobs < ActiveRecord::Migration
  def change
    create_table :politician_jobs, id: :uuid do |t|
      t.string  :organization
      t.string  :title
      t.string  :electoral_region
      t.integer :th
      t.timestamps null: false
    end
    add_index :politician_jobs, :title
    add_index :politician_jobs, :electoral_region
    add_index :politician_jobs, :organization
    add_index :politician_jobs, :th
  end
end
