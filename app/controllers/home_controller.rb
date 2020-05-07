class HomeController < ApplicationController
  def index
    custom_design_scope = CustomDesign.published.order(created_at: :desc).limit(12)

    @pagy, @custom_designs = pagy(custom_design_scope)
  end
end
