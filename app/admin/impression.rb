ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description,
                :impression_type, :infos, :web_pages,
                :user_id, :tag_ids => []

  form do |f|
    f.inputs "Impression Details" do
      f.input :official_name
      f.input :name
      f.input :description
      f.input :impression_type, collection: ['politician'], include_blank: false
      # f.input :gender, collection: [['男', 'male'], ['女', 'female']], include_blank: false
      # f.input :birthday
      f.input :infos
      f.input :web_pages
      f.input :tags,
              as: :select,
              input_html: {class: 'select2able'},
              collection: ActsAsTaggableOn::Tag.select(:id, :name).all
    end
    f.actions
  end

  controller do
    before_action :create_tags, only: [:create, :update]

    private

    def create_tags
      tag_ids = params[:impression][:tag_ids]

      tag_ids.each_index do |i|
        tag_id = tag_ids[i]
        if tag_id.present? && ActsAsTaggableOn::Tag.where(id: tag_id).blank?
          tag = ActsAsTaggableOn::Tag.create(name: tag_id)
          params[:impression][:tag_ids][i] = tag.id
        end
      end
    end

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
    end
    active_admin_comments
  end

end
