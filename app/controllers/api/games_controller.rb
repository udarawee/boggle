class Api::GamesController < ApplicationController
  def create
    render json: { board: board, valid_words: solver.find_all_words }
  end

  def save
    render json: { status: 'ok' }
  end

  def board
    @board ||= ::BoggleService.new.board
  end

  def solver
    @solver ||= BoggleSolver.new(board)
  end
end
