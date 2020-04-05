class Api::GamesController < ApplicationController
  def create
    render json: { board: board }
  end

  def board
    @board ||= ::BoggleService.new.board
  end
end
