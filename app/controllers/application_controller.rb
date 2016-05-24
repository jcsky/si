class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :setting_meta_tags, if: :not_staging_env

  def after_sign_in_path_for(resource)
    impressions_path || stored_location_for(resource) || root_path
  end

  def set_nav_bar_search_param
    @q = Impression.ransack(params[:q])
  end

  def setting_meta_tags
    set_meta_tags site: Settings.app_name, reverse: true,
      description: "你和民意代表的溝通平台",
      icon: view_context.image_url("solveissue.png"),
      author: "https://www.facebook.com/groups/solveissue/",
      og: {
        title:    Settings.app_name,
        type:     'application',
      }
    set_meta_tags nofollow: true if Rails.env == 'staging'
  end

  def not_staging_env
    Rails.env != 'staging'
  end
end
