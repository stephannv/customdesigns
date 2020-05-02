class HomeController < ApplicationController
  def index
    @latest_custom_designs = CustomDesign.order(created_at: :desc).limit(12)

    @trending_custom_designs = CustomDesign
      .joins(:hearts)
      .group('custom_designs.id')
      .order('count(hearts.id) DESC')
      .where('hearts.created_at >= now()::date')
      .limit(12)

    @most_loved_custom_designs = CustomDesign.order(hearts_count: :desc).limit(12)

    @most_loved_creators = Creator
      .select('creators.*, sum(custom_designs.hearts_count) as hearts_count')
      .joins(:custom_designs)
      .group('creators.id')
      .where.not(permanlink: nil)
      .order('sum(custom_designs.hearts_count) DESC')
      .limit(12)
  end
end
