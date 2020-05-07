class CustomDesignsController < ApplicationController
  before_action :require_admin, only: %i[unpublished edit update destroy publish unpublish]
  before_action :check_recaptcha, only: :create

  def unpublished
    scope = CustomDesign.unpublished

    @pagy, @custom_designs = pagy(scope)
  end

  def show
    @custom_design = find_custom_design
  end

  def new
    @custom_design = CustomDesign.new
    @custom_design.build_main_picture
    @custom_design.build_example_picture
    load_categories
  end

  def create
    @custom_design = CustomDesign.new(custom_design_params)
    @custom_design.published = current_admin.present?

    if @custom_design.save
      redirect_to @custom_design, success: 'Custom design created with success'
    else
      @custom_design.build_example_picture if @custom_design.example_picture.blank?
      load_categories
      render 'new'
    end
  end

  def edit
    @custom_design = find_custom_design
    @custom_design.build_example_picture if @custom_design.example_picture.blank?
    load_categories
  end

  def update
    @custom_design = find_custom_design

    if @custom_design.update(custom_design_params)
      redirect_to @custom_design, success: 'Custom design updated with success'
    else
      @custom_design.build_example_picture if @custom_design.example_picture.blank?
      load_categories
      render 'edit'
    end
  end

  def destroy
    @custom_design = CustomDesign.find_by!(design_id: params[:design_id])

    if @custom_design.destroy!
      options = { success: 'Custom design destroyed with success' }
    else
      options = { error: 'An error occurred' }
    end

    redirect_to custom_designs_path, options
  end

  def publish
    @custom_design = find_custom_design

    if @custom_design.update(published: true)
      redirect_to @custom_design, success: 'Custom Design was published'
    else
      redirect_back fallback_location: @custom_design, error: 'An error occurred'
    end
  end

  def unpublish
    @custom_design = find_custom_design

    if @custom_design.update(published: false)
      redirect_to @custom_design, success: 'Custom Design was unpublished'
    else
      redirect_back fallback_location: @custom_design, error: 'An error occurred'
    end
  end

  private
  def find_custom_design
    CustomDesign.find_by!(design_id: params[:design_id])
  end

  def check_recaptcha
    return if current_admin.present?

    validate_recaptcha!(token: params[:recaptcha_token], action: 'upload')
  end

  def load_categories
    @categories = Category.all
  end

  def custom_design_params
    raw_tags = params.require(:custom_design).delete(:tags)

    sanitized_params = params.require(:custom_design).permit(
      :name,
      :design_id,
      :creator_name,
      :creator_id,
      main_picture_attributes: %i[id image],
      example_picture_attributes: %i[id image],
      category_ids: []
    ).merge(tag_ids: handle_tag_ids(raw_tags))

    sanitized_params[:category_ids].reject!(&:blank?)
    sanitized_params
  end

  def handle_tag_ids(raw_tags)
    tag_names = JSON.parse(raw_tags).flat_map(&:values).reject(&:blank?)
    tags = tag_names.to_a.first(5).map do |name|
      tag = Tag.find_by('lower(unaccent(name)) = lower(unaccent(?))', name.strip)
      tag || Tag.create!(name: name.strip) rescue nil
    end
    tags.compact.map(&:id)
  rescue => e
    []
  end
end

