class Api::GamesController < ApplicationController
  def create
    render json: {
      board: board,
      valid_words: solver.find_all_words.map { |w| Digest::MD5.hexdigest(w) }
    }
  end

  def board
    @board ||= BoggleService.new.board
  end

  def solver
    @solver ||= BoggleSolver.new(board)
  end
end
