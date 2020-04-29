class HeartsController < ApplicationController
  before_action :require_login

  def create
    if current_creator.hearts.create(custom_design_id: params[:custom_design_id])
      render json: { status: :ok }
    else
      render json: { status: :error }, status: 401
    end
  end

  def destroy
    bookmark = current_creator.hearts.find_by(custom_design_id: params[:custom_design_id])

    if bookmark.try(:destroy)
      render json: { status: :ok }
    else
      render json: { status: :error }, status: 409
    end
  end
end
