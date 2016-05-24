# == Schema Information
#
# Table name: impressions
#
#  id              :uuid             not null, primary key
#  reputation      :integer          default(0)
#  official_name   :string
#  name            :string           not null
#  description     :text
#  impression_type :string
#  infos           :hstore
#  web_pages       :hstore
#  user_id         :uuid
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ImpressionsController < ApplicationController
  layout "home"
  before_action :set_impression, only: [:show, :like, :unlike]
  before_action :set_nav_bar_search_param, only: [:index, :show]
  before_action :meta_tags_on_show, only: :show

  def index
    @q = Impression.ransack(params[:q])
    @impressions = @q.result.best.page(params[:page])
    @impressions.last_page? ? @next_page = nil : @next_page = @impressions.next_page
    @load_params = {q: (params[:q] || {})}.merge(page: @next_page)
    respond_to do |format|
      format.html { set_meta_tags keywords: @impressions.pluck(:name) }
      format.js
    end
  end

  def show
    @vote_chart_data = Hash[@impression.vote_histories.pluck(:date_on,:reputation)]
  end

  def like
    if current_user && !current_user.voted_for?(@impression)
      current_user.vote_exclusively_for(@impression)
      @impression.update(reputation: @impression.plusminus)
    end
    replace_card
  end

  def unlike
    if current_user && !current_user.voted_against?(@impression)
      current_user.vote_exclusively_against(@impression)
      @impression.update(reputation: @impression.plusminus)
    end
    replace_card
  end

  private

  def replace_card
    respond_to do |format|
      format.js { render :replace_card}
    end
  end

  def set_impression
    @impression = Impression.find(params[:id])
  end

  def meta_tags_on_show
    set_meta_tags title: @impression.name,
      description: @impression.description,
      keywords: @impression.politician_jobs.pluck(:title).uniq.push(@impression.name)
  end
end
