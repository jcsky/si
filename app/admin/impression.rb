ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description,
                :impression_type, :gender, :birthday, :infos, :web_pages,
                :user_id, :website, :fb_fan_page, :email, tag_ids: [], party_ids: []

  form do |f|
    f.inputs "Impression Details" do
      f.input :official_name
      f.input :name
      f.input :description
      f.input :impression_type, collection: ['politician'], include_blank: false
      f.input :gender, collection: [['男', 'male'], ['女', 'female']], include_blank: false
      f.input :birthday, :as => :datepicker
      f.input :email
      f.input :website
      f.input :fb_fan_page
      f.input :tags, label: "tag",
              as: :select,
              input_html: {class: 'select2able'},
              collection: ActsAsTaggableOn::Tag.all.pluck(:name)
      f.input :parties, label: "parties tag",
              as: :select,
              input_html: {class: 'select2able'},
              collection: ActsAsTaggableOn::Tagging.where(context: "party", taggable_type: "Impression").includes(:tag).pluck(:name)
    end
    f.actions
  end

  controller do

    def create
      impression_params = permitted_params[:impression]
      tags = impression_params.extract!(:tag_ids)
      parties = impression_params.extract!(:party_ids)
      impression = Impression.new(impression_params)
      impression.tag_list = tags["tag_ids"]
      impression.set_tag_list_on(:party, parties["party_ids"])
      impression.save
    end

    def update
      impression_params = permitted_params[:impression]
      tags = impression_params.extract!(:tag_ids)
      parties = impression_params.extract!(:party_ids)
      impression = Impression.find(params[:id])
      impression.tag_list = tags["tag_ids"]
      impression.set_tag_list_on(:party, parties["party_ids"])
      impression.update(impression_params)
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
      row 'Tags on party' do
        impression.tags_on(:party).each do |tag|
          span tag
        end
      end
    end
    active_admin_comments
  end

end
