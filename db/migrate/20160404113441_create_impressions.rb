class CreateImpressions < ActiveRecord::Migration
  def change
    enable_extension "hstore"

    create_table :impressions, id: :uuid do |t|
      t.integer :reputation, default: 0
      t.string  :official_name
      t.string  :name, null: false
      t.text    :description
      t.string  :impression_type
      t.hstore  :infos
      t.hstore  :web_pages
      t.uuid    :user_id
      t.timestamps null: false
    end

    add_index :impressions, :name
    add_index :impressions, :user_id
    add_index :impressions, :impression_type
  end
end
