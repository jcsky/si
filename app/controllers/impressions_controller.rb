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

  def index
    @impressions = Impression.all.page(params[:page])
  end

  def show; end

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
end
