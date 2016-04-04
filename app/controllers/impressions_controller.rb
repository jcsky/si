class ImpressionsController < ApplicationController
  layout "home"
  def index
    @impressions = Impression.all
  end

end
