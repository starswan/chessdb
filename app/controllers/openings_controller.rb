class OpeningsController < ApplicationController

  before_action :find_opening, only: %i[edit update destroy]
  # GET /openings
  # GET /openings.json
  def index
    scope = if params[:page].present?
              ChessOpening.where("name > ?", params[:page])
            else
              ChessOpening.all
            end
    @openings = scope.where.not(games_count: 0).order(:name, :variation, :ecocode)
  end

  def edit
  end

  def update
    @opening.update! opening_params

    redirect_to openings_path
  end

  def destroy
    @opening.destroy
    redirect_to openings_path(page: @opening.name[0..1])
  end

  private

  def opening_params
    params.require(:opening).permit(:name, :ecocode)
  end

  def find_opening
    @opening = ChessOpening.find(params[:id])
  end
end
