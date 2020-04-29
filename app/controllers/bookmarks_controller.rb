class BookmarksController < ApplicationController
  before_action :require_login

  def index
    scope = current_creator.bookmarked_custom_designs
      .select('custom_designs.*, bookmarks.created_at')
      .joins(:main_picture)
      .left_joins(:categories, :tags, :hearts)
      .includes(:main_picture, :categories, :tags, :hearts)
      .order('bookmarks.created_at DESC')
      .distinct

    @pagy, @custom_designs = pagy(scope)
  end

  def create
    if current_creator.bookmarks.create(custom_design_id: params[:custom_design_id])
      render json: { status: :ok }
    else
      render json: { status: :error }, status: 401
    end
  end

  def destroy
    bookmark = current_creator.bookmarks.find_by(custom_design_id: params[:custom_design_id])

    if bookmark.try(:destroy)
      render json: { status: :ok }
    else
      render json: { status: :error }, status: 409
    end
  end
end
