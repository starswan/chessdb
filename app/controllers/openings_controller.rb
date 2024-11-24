class OpeningsController < ApplicationController

  before_action :find_opening, only: %i[destroy]
  # GET /openings
  # GET /openings.json
  def index
    scope = if params[:page].present?
              ChessOpening.where("name >= ?", params[:page])
            else
              ChessOpening.all
            end
    @openings = scope.where.not(games_count: 0).order(:name, :variation, :ecocode).group_by(&:name)
  end

  def show
  end

  def destroy
    @opening.destroy
    redirect_to openings_path(page: @opening.name.split(" ,")[..-1].join(" ,"))
  end

  private

  def find_opening
    @opening = ChessOpening.find(params[:id])
  end
end
