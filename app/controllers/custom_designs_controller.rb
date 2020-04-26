class CustomDesignsController < ApplicationController
  before_action :require_login, only: %i[index new create edit update destroy]

  def index
    @custom_designs = current_creator.custom_designs.order(created_at: :desc)
  end

  def show
    @custom_design = CustomDesign.find(params[:id])
  end

  def new
    @custom_design = current_creator.custom_designs.new
    @custom_design.build_main_picture
    @custom_design.build_example_picture
  end

  def create
    @custom_design = current_creator.custom_designs.new(custom_design_params)

    if @custom_design.save
      redirect_to @custom_design, success: 'Custom design created with success'
    else
      @custom_design.build_example_picture if @custom_design.example_picture.blank?
      render 'new'
    end
  end

  def edit
    @custom_design = current_creator.custom_designs.find(params[:id])
    @custom_design.build_example_picture if @custom_design.example_picture.blank?
  end

  def update
    @custom_design = current_creator.custom_designs.find(params[:id])

    if @custom_design.update(custom_design_params)
      redirect_to @custom_design, success: 'Custom design updated with success'
    else
      render 'edit'
    end
  end

  def destroy
    @custom_design = current_creator.custom_designs.find(params[:id])

    if @custom_design.destroy!
      options = { success: 'Custom design destroyed with success' }
    else
      options = { error: 'An error occurred' }
    end

    redirect_to custom_designs_path, options
  end

  private

  def custom_design_params
    params.require(:custom_design).permit(
      :name,
      :design_id,
      main_picture_attributes: %i[id image],
      example_picture_attributes: %i[id image]
    )
  end
end

