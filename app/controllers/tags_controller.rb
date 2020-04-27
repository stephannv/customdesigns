class TagsController < ApplicationController
  before_action :require_login

  def index
    if params[:search].present?
      tags = Tag
        .where('unaccent(lower(name)) ilike unaccent(lower(?))', "%#{params[:search]}%")
        .limit(10)
        .pluck(:name)
      render json: tags
    else
      render json: []
    end
  end
end
