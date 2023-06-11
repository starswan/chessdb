# frozen_string_literal: true
#
# $Id$
#
module Players
  class GamesController < ApplicationController
    before_action :find_player

    def index
      @games = Game.by_player(@player).order(date: :desc)
    end

  private

    def find_player
      @player = Player.find(params[:player_id])
    end
  end
end
