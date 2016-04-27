ActiveAdmin.register ActsAsTaggableOn::Tagging do

  index do
    selectable_column
    column :id
    column :taggable_type
    column :taggable_id
    column :tag do |t|
      t.tag.name if t.tag
    end
    column :taggable_type

  end

  show do
    attributes_table do
      row :id
      row :taggable_type
      row :taggable_id
      row :taggable_type
      row "tag name" do |tag|
        span tag
      end
      row :context
    end
    active_admin_comments
  end

end
