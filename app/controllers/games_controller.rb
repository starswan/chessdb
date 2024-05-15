class GamesController < ApplicationController
  before_action :set_game, only: [:show, :edit, :update, :destroy]
  before_action :set_opening, only: [:new, :create]

  layout 'elmboard', only: :show

  # GET /games
  # GET /games.json
  def index
    @games = Game.includes(:moves, :opening, :white, :black).order(:date).all.page(1)
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.includes(:moves).find params[:id]
    @position = ['rnbqkbnr', 'pppppppp', ' ' * 8, ' ' * 8, ' ' * 8, ' ' * 8, 'PPPPPPPP', 'RNBQKBNR']
  end

  # GET /games/new
  def new
    @game = @opening.games.new
  end

  # GET /games/1/edit
  def edit
  end

  # POST /games
  # POST /games.json
  def create
    @game = @opening.games.new(game_params)

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render :show, status: :created, location: @game }
      else
        format.html { render :new }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /games/1
  # PATCH/PUT /games/1.json
  def update
    respond_to do |format|
      if @game.update(game_params)
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { render :show, status: :ok, location: @game }
      else
        format.html { render :edit }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game.destroy
    respond_to do |format|
      format.html { redirect_to opening_games_url(@game.opening), notice: 'Game was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

private

  def set_game
    @game = Game.includes(:moves).find(params[:id])
  end

  def set_opening
    @opening = ChessOpening.find(params[:opening_id])
  end

  def game_params
    params.require(:game).permit(:white_id, :black_id, :date, :white_elo, :black_elo, :result, :pgn, :number_of_moves, :site)
  end
end
