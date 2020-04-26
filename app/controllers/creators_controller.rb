class CreatorsController < ApplicationController
  before_action :require_login

  def edit
    @creator = current_user.creator
  end

  def update
    @creator = current_user.creator

    if @creator.update(creator_params)
      redirect_to root_path, success: 'Profile updated with success'
    else
      render 'edit'
    end
  end

  private

  def creator_params
    params.require(:creator).permit(:name, :creator_id)
  end
end
