#
# $Id$
#
class MovesController < ApplicationController
  before_action :set_move, only: [:show]
  before_action :set_game, only: [:index, :new, :create]

  # GET /moves
  # GET /moves.json
  def index
    if @game.moves.count < @game.number_of_moves
      @game.create_moves!
    end
    @moves = @game.moves.order(:number)
  end

  # GET /moves/1
  # GET /moves/1.json
  def show
    @game = @move.game
    @moves = @game.moves.where('number <= ?', @move.number).order(:number)
  end

  # GET /moves/new
  def new
    @move = @game.moves.new
  end

  # POST /moves
  # POST /moves.json
  def create
    @move = @game.moves.new(move_params)

    respond_to do |format|
      if @move.save
        format.html { redirect_to @move, notice: 'Move was successfully created.' }
        format.json { render :show, status: :created, location: @move }
      else
        format.html { render :new }
        format.json { render json: @move.errors, status: :unprocessable_entity }
      end
    end
  end

private

    # Use callbacks to share common setup or constraints between actions.
  def set_move
    @move = Move.find(params[:id])
  end

  def set_game
    @game = Game.find params[:game_id]
  end

    # Never trust parameters from the scary internet, only allow the white list through.
  def move_params
    params.require(:move).permit(:game_id, :number, :move, :from, :to, :piece, :fen)
  end
end
