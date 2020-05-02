class CreatorsController < ApplicationController
  before_action :require_login, only: %i[edit update]

  def show
    @creator = Creator.find_by!(permanlink: params[:permanlink])
    custom_design_scope = @creator.custom_designs.order(created_at: :desc)
    @pagy, @custom_designs = pagy(custom_design_scope)
  end

  def edit
    @creator = current_user.creator
  end

  def update
    @creator = current_user.creator

    if @creator.update(creator_params)
      if @creator.permanlink.present?
        redirect_to creator_path(@creator), success: 'Profile updated with success'
      else
        redirect_to root_path, success: 'Profile updated with success'
      end
    else
      render 'edit'
    end
  end

  private

  def creator_params
    sanitized_params = params.require(:creator).permit(
      %i[permanlink name creator_id island_name twitter_username friend_code]
    )
    sanitized_params[:creator_id] = '' if sanitized_params[:creator_id] == 'MA-'
    sanitized_params[:friend_code] = '' if sanitized_params[:friend_code] == 'SW-'
    sanitized_params
  end
end
