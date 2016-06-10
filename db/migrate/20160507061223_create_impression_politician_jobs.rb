class CreateImpressionPoliticianJobs < ActiveRecord::Migration
  def change
    create_table :impression_politician_jobs, id: :uuid do |t|
      t.uuid  :impression_id
      t.uuid  :politician_job_id
      t.date  :started_on
      t.date  :ended_on
      t.timestamps null: false
    end
    add_index :impression_politician_jobs, :impression_id
    add_index :impression_politician_jobs, :politician_job_id
  end
end
