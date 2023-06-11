module Openings
  class GamesController < ApplicationController
    before_action :find_opening

    def index
      @games = Game.by_opening(@opening).order(date: :desc)
      render 'games/index'
    end

    private

    def find_opening
      @opening = ChessOpening.find(params[:opening_id])
    end
  end
end
