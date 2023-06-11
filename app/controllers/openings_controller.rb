class OpeningsController < ApplicationController
  # GET /openings
  # GET /openings.json
  def index
    @openings = ChessOpening.order(:ecocode, :name, :variation).reject { |o| o.games_count == 0 }
  end

  def edit
    @opening = ChessOpening.find params[:id]
  end

  def update
    @opening = ChessOpening.find params[:id]
    @opening.update! opening_params

    redirect_to openings_path
  end

  def destroy
    ChessOpening.find(params[:id]).destroy
    redirect_to openings_path
  end

  private

  def opening_params
    params.require(:opening).permit(:name, :ecocode)
  end
end
