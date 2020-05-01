class SearchController < ApplicationController
  def index
    @search_term = params[:q].to_s.tr('^[a-zA-ZÀ-ú0-9-_. ]*', '').strip

    if @search_term.present?
      scope = CustomDesign.search_by_everything(@search_term)
    else
      scope = CustomDesign.none
    end

    @pagy, @custom_designs = pagy(scope)
  end
end
