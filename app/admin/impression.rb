ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description,
                :impression_type, :gender, :birthday, :infos, :web_pages,
                :user_id, :website, :fb_fan_page, :email

  form do |f|
    f.inputs "Impression Details" do
      # raise 'p'
      f.input :official_name
      f.input :name
      f.input :description
      f.input :impression_type, collection: ['politician'], include_blank: false
      f.input :gender, collection: [['男', 'male'], ['女', 'female']], include_blank: false
      f.input :birthday, :as => :datepicker
      f.input :email
      f.input :website
      f.input :fb_fan_page
      f.input :tag_list, label: "tag_list",
              as: :select,
              multiple: true,
              input_html: {class: 'select2able'},
              collection: ActsAsTaggableOn::Tag.all.pluck(:name)
      f.input :party_list, label: "party_list",
              as: :select,
              multiple: true,
              input_html: {class: 'select2able'},
              collection: ActsAsTaggableOn::Tag.all.pluck(:name)
    end
    f.actions
  end

  controller do

    def create
      @impression = Impression.new(impression_params)
      edit_tag
      @impression.save
      redirect_to admin_impression_path(@impression)
    end

    def update
      @impression = Impression.find(params[:id])
      edit_tag
      @impression.update(impression_params)
      redirect_to admin_impressions_path
    end

    private

    def impression_params
      permitted_params[:impression]
    end

    def edit_tag
      @impression.tag_list = params[:impression]["tag_list"]
      @impression.set_tag_list_on(:party, params[:impression]["party_list"])
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
