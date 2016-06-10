ActiveAdmin.register ActsAsTaggableOn::Tagging do

  index do
    selectable_column
    column :id, sortable: :id do |tagging|
      link_to tagging.id, admin_acts_as_taggable_on_tagging_path(tagging)
    end
    column :taggable_type
    column :taggable_id
    column :tag do |t|
      t.tag.name if t.tag
    end
    column :context

  end

  show do
    attributes_table do
      row :id
      row :taggable_type
      row :taggable_id
      row :taggable_type
      row "tag name" do |tagging|
        tagging.tag.name if tagging.tag
      end
      row :context
    end
    active_admin_comments
  end

end
