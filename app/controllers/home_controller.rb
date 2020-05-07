class HomeController < ApplicationController
  def index
    custom_design_scope = CustomDesign.published.order(created_at: :desc)

    @pagy, @custom_designs = pagy(custom_design_scope)
  end
end
