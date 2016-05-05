ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description,
                :impression_type, :gender, :birthday, :infos, :web_pages,
                :user_id, :website, :fb_fan_page, :email
  scope  :politician

  index do
    id_column
    column :reputation
    column :official_name
    column :name
    column :impression_type
    column :gender
    column :birthday
    column :fb_fan_page
    column :user_id
    column :tag_list
    column :party_list
    column :job_list
    column :past_job_list
    column :electoral_district_list
    actions
  end


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
      f.input :tag_list, label: "tag_list",
              as: :select, multiple: true, input_html: {class: 'select2able'},
              collection: Impression.tag_counts.pluck(:name)
      f.input :party_list, label: "party_list",
              as: :select, multiple: true, input_html: {class: 'select2able'},
              collection: Impression.party_counts.pluck(:name)
      f.input :job_list, label: "job_list",
              as: :select, multiple: true, input_html: {class: 'select2able'},
              collection: Impression.job_counts.pluck(:name)
      f.input :past_job_list, label: "past_job_list",
              as: :select, multiple: true, input_html: {class: 'select2able'},
              collection: Impression.past_job_counts.pluck(:name)
      f.input :electoral_district_list, label: "electoral_district_list",
              as: :select, multiple: true, input_html: {class: 'select2able'},
              collection: Impression.electoral_district_counts.pluck(:name)
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
      @impression.tag_list = params[:impression]["tag_list"].reject(&:empty?)
      @impression.set_tag_list_on(:party, params[:impression]["party_list"]).reject(&:empty?)
      @impression.set_tag_list_on(:job, params[:impression]["job_list"]).reject(&:empty?)
      @impression.set_tag_list_on(:electoral_district, params[:impression]["electoral_district_list"]).reject(&:empty?)
      @impression.set_tag_list_on(:past_job, params[:impression]["past_job_list"]).reject(&:empty?)
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
      row :tag_list
      row :party_list
      row :job_list
      row :past_job_list
      row :electoral_district_list
    end
    active_admin_comments
  end

end
