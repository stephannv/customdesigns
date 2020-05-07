class CreatorsController < ApplicationController
  def show
    custom_design_scope = CustomDesign.where(creator_id: params[:creator_id])
    @pagy, @custom_designs = pagy(custom_design_scope)

    raise ActiveRecord::RecordNotFound if @pagy.count == 0
  end
end
