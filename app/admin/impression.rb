ActiveAdmin.register Impression do
  permit_params :reputation, :official_name, :name, :description, :impression_type, :gender, :birthday, :infos, :web_pages, :user_id


end
