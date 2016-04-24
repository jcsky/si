class CreatePoliticians < ActiveRecord::Migration
  def change
    create_table :politicians, id: :uuid do |t|
      t.date    :birthday
      t.integer :age
      t.string  :current_job
      t.string  :gender
      t.string  :party
      t.string  :image
      t.string  :email
      t.timestamps null: false
    end
  end
end
