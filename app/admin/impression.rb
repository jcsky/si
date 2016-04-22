ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description,
                :impression_type, :gender, :birthday, :infos, :web_pages,
                :user_id, :tag_ids => []

  form do |f|
    f.inputs "Impression Details" do
      # f.input :reputation
      f.input :official_name
      f.input :name
      f.input :description
      f.input :impression_type, collection: ['politician'], include_blank: false
      f.input :gender, collection: [['男', 'male'], ['女', 'female']], include_blank: false
      f.input :birthday
      f.input :infos
      f.input :web_pages
      f.input :tags,  # Show all tags AND checked already selected one (by relations through :tags - input must named :tags)
              as: :select2_multiple, new_record: true,
              collection: ActsAsTaggableOn::Tag.select(:id, :name).all
    end
    f.actions
  end

  show do
    attributes_table do
      row :impression_type
      row :official_name
      row :name
      row :reputation
      row :description
      row :gender
      row :birthday
      row :infos
      row :web_pages
      row :user
      row 'Tags' do
        impression.tags.each do |tag|
          span tag
        end
      end
      #
      # row :image do
      #   image_tag ad.image.url
      # end
    end
    active_admin_comments
  end

end
