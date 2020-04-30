class SearchController < ApplicationController
  def index
    @search_term = params[:q]
    scope = CustomDesign.search_by_everything(@search_term)
    @pagy, @custom_designs = pagy(scope)
  end
end
